path = require 'path'

module.exports =
  config:
    jsxhintExecutablePath:
      type: 'string'
      default: path.join __dirname, '..', 'node_modules', '.bin'
      description: 'Path of `jsxhint` executable.'
    harmony:
      type: 'boolean'
      default: false
      description: 'Use react esprima with ES6 transformation support.'

  activate: ->
    console.log 'activate linter-jsxhint'
