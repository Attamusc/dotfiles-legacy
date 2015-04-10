{EditorView} = require 'atom'
{BufferedProcess} = require 'atom'
ScalaProcess = require './scala-process'
ScalaLineProcessor = require './scala-line-processor'

module.exports =
  configDefaults:
    scalaProcess: "scala"

  activate: (state) ->
    atom.workspaceView.command "scala-worksheet:run", =>
      @prepareRun () => @executeWorkSheet @sourcesEditor.getText(), @sourcesEditors

  deactivate: ()->
    @scalaProcess.stdin.end()
    @scalaProcess.kill()

  prepareRun: (callback)->
    sourcesPane = @findSourcesPane()

    @sourcesEditor = sourcesPane.getActiveEditor()
    @scalaLiner = new ScalaLineProcessor @sourcesEditor
    if not @scalaProcess?
      @scalaProcess = new ScalaProcess atom.config.get 'scala-worksheet.scalaProcess'
      @scalaProcess.setBlockCallback (block) =>
        for line in block.split "\n"
          @scalaLiner.processLine line
      @scalaProcess.setErrorCallback (error) ->
        console.log "Error: #{error}"
      @scalaProcess.initialize ()-> callback()

    callback()


  findSourcesPane: () ->
    panes = atom.workspace.getPanes()
    panes[0]

  executeWorkSheet: (source, targetEditor)->
    @scalaProcess.writeBlock source
