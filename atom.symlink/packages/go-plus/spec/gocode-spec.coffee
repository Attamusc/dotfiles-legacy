path = require('path')
_ = require('underscore-plus')
AtomConfig = require('./util/atomconfig')

describe 'gocode', ->
  [workspaceElement, editor, editorView, dispatch, buffer, completionDelay, goplusMain, autocompleteMain, autocompleteManager, provider] = []

  beforeEach ->
    runs ->
      atomconfig = new AtomConfig()
      atomconfig.allfunctionalitydisabled()

      # Enable live autocompletion
      atom.config.set('autocomplete-plus.enableAutoActivation', true)
      atom.config.set('go-plus.suppressBuiltinAutocompleteProvider', false)
      # Set the completion delay
      completionDelay = 100
      atom.config.set('autocomplete-plus.autoActivationDelay', completionDelay)
      completionDelay += 100 # Rendering delay

      workspaceElement = atom.views.getView(atom.workspace)
      jasmine.attachToDOM(workspaceElement)

      pack = atom.packages.loadPackage('go-plus')
      goplusMain = pack.mainModule
      spyOn(goplusMain, 'provide').andCallThrough()
      spyOn(goplusMain, 'setDispatch').andCallThrough()
      pack = atom.packages.loadPackage('autocomplete-plus')
      autocompleteMain = pack.mainModule
      spyOn(autocompleteMain, 'consumeProvider').andCallThrough()
      jasmine.unspy(window, 'setTimeout')

    waitsForPromise -> atom.workspace.open('gocode.go').then (e) ->
      editor = e
      editorView = atom.views.getView(editor)

    waitsForPromise ->
      atom.packages.activatePackage('autocomplete-plus')

    waitsFor ->
      autocompleteMain.autocompleteManager?.ready

    runs ->
      autocompleteManager = autocompleteMain.getAutocompleteManager()
      spyOn(autocompleteManager, 'displaySuggestions').andCallThrough()
      spyOn(autocompleteManager, 'showSuggestionList').andCallThrough()
      spyOn(autocompleteManager, 'hideSuggestionList').andCallThrough()

    waitsForPromise ->
      atom.packages.activatePackage('language-go')

    runs ->
      expect(goplusMain.provide).not.toHaveBeenCalled()
      expect(goplusMain.provide.calls.length).toBe(0)

    waitsForPromise ->
      atom.packages.activatePackage('go-plus')

    waitsFor ->
      goplusMain.provide.calls.length is 1

    waitsFor ->
      autocompleteMain.consumeProvider.calls.length is 1

    waitsFor ->
      goplusMain.dispatch?.ready

    waitsFor ->
      goplusMain.setDispatch.calls.length >= 1

    runs ->
      expect(goplusMain.provide).toHaveBeenCalled()
      expect(goplusMain.provider).toBeDefined()
      provider = goplusMain.provider
      spyOn(provider, 'getSuggestions').andCallThrough()
      expect(_.size(autocompleteManager.providerManager.providersForScopeDescriptor('.source.go'))).toEqual(1)
      expect(autocompleteManager.providerManager.providersForScopeDescriptor('.source.go')[0]).toEqual(provider)
      buffer = editor.getBuffer()
      dispatch = atom.packages.getLoadedPackage('go-plus').mainModule.dispatch
      dispatch.goexecutable.detect()

  afterEach ->
    jasmine.unspy(goplusMain, 'provide')
    jasmine.unspy(goplusMain, 'setDispatch')
    jasmine.unspy(autocompleteManager, 'displaySuggestions')
    jasmine.unspy(autocompleteMain, 'consumeProvider')
    jasmine.unspy(autocompleteManager, 'hideSuggestionList')
    jasmine.unspy(autocompleteManager, 'showSuggestionList')
    jasmine.unspy(provider, 'getSuggestions')

  describe 'when the gocode autocomplete-plus provider is enabled', ->

    it 'displays suggestions from gocode', ->
      runs ->
        expect(provider).toBeDefined()
        expect(provider.getSuggestions).not.toHaveBeenCalled()
        expect(autocompleteManager.displaySuggestions).not.toHaveBeenCalled()
        expect(editorView.querySelector('.autocomplete-plus')).not.toExist()

        editor.setCursorScreenPosition([5, 6])
        advanceClock(completionDelay)

      waitsFor ->
        autocompleteManager.hideSuggestionList.calls.length is 1

      runs ->
        editor.insertText('P')
        advanceClock(completionDelay)

      waitsFor ->
        autocompleteManager.displaySuggestions.calls.length is 1

      runs ->
        expect(provider.getSuggestions).toHaveBeenCalled()
        expect(provider.getSuggestions.calls.length).toBe(1)
        expect(editorView.querySelector('.autocomplete-plus')).toExist()
        expect(editorView.querySelector('.autocomplete-plus span.word').innerHTML).toBe('<span class="character-match">P</span>rint(<span class="snippet-completion">a ...interface</span>)')
        expect(editorView.querySelector('.autocomplete-plus span.left-label').innerHTML).toBe('n int, err error')
        editor.backspace()

    xit 'does not display suggestions when no gocode suggestions exist', ->
      runs ->
        expect(editorView.querySelector('.autocomplete-plus')).not.toExist()

        editor.setCursorScreenPosition([6, 15])
        advanceClock(completionDelay)

      waitsFor ->
        autocompleteManager.hideSuggestionList.calls.length is 1

      runs ->
        editor.insertText('w')
        advanceClock(completionDelay)

      waitsFor ->
        autocompleteManager.hideSuggestionList.calls.length is 2

      runs ->
        expect(editorView.querySelector('.autocomplete-plus')).not.toExist()

    it 'does not display suggestions at the end of a line when no gocode suggestions exist', ->
      runs ->
        expect(editorView.querySelector('.autocomplete-plus')).not.toExist()

        editor.setCursorScreenPosition([5, 15])
        advanceClock(completionDelay)

      waitsFor ->
        autocompleteManager.hideSuggestionList.calls.length is 1

      runs ->
        editor.backspace()
        editor.insertText(')')
        advanceClock(completionDelay)

      waitsFor ->
        autocompleteManager.displaySuggestions.calls.length is 1

      runs ->
        expect(editorView.querySelector('.autocomplete-plus')).not.toExist()
        editor.insertText(';')

      waitsFor ->
        autocompleteManager.displaySuggestions.calls.length is 1
        advanceClock(completionDelay)

      runs ->
        expect(editorView.querySelector('.autocomplete-plus')).not.toExist()
