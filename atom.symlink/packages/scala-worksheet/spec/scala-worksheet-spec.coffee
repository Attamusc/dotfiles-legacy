{WorkspaceView} = require 'atom'
ScalaWorksheet = require '../lib/scala-worksheet'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "ScalaWorksheet", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('scala-worksheet')

  describe "when the scala-worksheet:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.scala-worksheet')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'scala-worksheet:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.scala-worksheet')).toExist()
        atom.workspaceView.trigger 'scala-worksheet:toggle'
        expect(atom.workspaceView.find('.scala-worksheet')).not.toExist()
