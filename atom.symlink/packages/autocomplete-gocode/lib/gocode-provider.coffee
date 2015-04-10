childProcess = require "child_process"
{Provider, Suggestion} = require "autocomplete-plus"

module.exports =
class GocodeProvider extends Provider
  buildSuggestions: (cb) ->
    position = @editor.getCursorBufferPosition()

    scopes = @editor.scopeDescriptorForBufferPosition(position).getScopesArray()
    return if scopes.indexOf("string.quoted.double.go") != -1
    return if scopes.indexOf("comment.line.double-slash.go") != -1

    index = @editor.getBuffer().characterIndexForPosition(position)
    offset = "c" + index.toString()
    text = @editor.getText()

    result = childProcess.spawnSync "gocode", ["-f=json", "autocomplete", offset],
      input: text

    if result.error or result.status
      console.log "failed to run gocode:", result
      return

    res = JSON.parse(result.stdout)

    numPrefix = res[0]
    candidates = res[1]

    return unless candidates

    suggestions = []
    for c in candidates
      prefix = c.name.substring 0, numPrefix

      word = c.name
      word += "(" if c.class is "func" and text[index] != "("

      label = c.type or c.class

      suggestions.push new Suggestion(this, word: word, prefix: prefix, label: label)

    return suggestions
