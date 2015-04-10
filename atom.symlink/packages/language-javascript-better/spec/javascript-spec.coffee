{TextEditor} = require 'atom'

describe "Javascript grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-javascript-better")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.js")

  it "parses the grammar", ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe "source.js"

  describe "strings", ->
    it "tokenizes single-line strings", ->
      delimsByScope =
        "string.quoted.double.js": '"'
        "string.quoted.single.js": "'"

      for scope, delim of delimsByScope
        {tokens} = grammar.tokenizeLine(delim + "x" + delim)
        expect(tokens[0].value).toEqual delim
        expect(tokens[0].scopes).toEqual ["source.js", scope, "punctuation.definition.string.begin.js"]
        expect(tokens[1].value).toEqual "x"
        expect(tokens[1].scopes).toEqual ["source.js", scope]
        expect(tokens[2].value).toEqual delim
        expect(tokens[2].scopes).toEqual ["source.js", scope, "punctuation.definition.string.end.js"]

  describe "keywords", ->
    it "tokenizes with as a keyword", ->
      {tokens} = grammar.tokenizeLine('with')
      expect(tokens[0]).toEqual value: 'with', scopes: ['source.js', 'keyword.control.js']

  describe "regular expressions", ->
    it "tokenizes regular expressions", ->
      {tokens} = grammar.tokenizeLine('/test/')
      expect(tokens[0]).toEqual value: '/', scopes: ['source.js', 'string.regexp.js', 'punctuation.definition.string.begin.js']
      expect(tokens[1]).toEqual value: 'test', scopes: ['source.js', 'string.regexp.js']
      expect(tokens[2]).toEqual value: '/', scopes: ['source.js', 'string.regexp.js', 'punctuation.definition.string.end.js']

      {tokens} = grammar.tokenizeLine('foo + /test/')
      expect(tokens[0]).toEqual value: 'foo ', scopes: ['source.js']
      expect(tokens[1]).toEqual value: '+', scopes: ['source.js', 'keyword.operator.js']
      expect(tokens[2]).toEqual value: ' ', scopes: ['source.js', 'string.regexp.js']
      expect(tokens[3]).toEqual value: '/', scopes: ['source.js', 'string.regexp.js', 'punctuation.definition.string.begin.js']
      expect(tokens[4]).toEqual value: 'test', scopes: ['source.js', 'string.regexp.js']
      expect(tokens[5]).toEqual value: '/', scopes: ['source.js', 'string.regexp.js', 'punctuation.definition.string.end.js']

    it "tokenizes regular expressions inside arrays", ->
      {tokens} = grammar.tokenizeLine('[/test/]')
      expect(tokens[0]).toEqual value: '[', scopes: ['source.js', 'meta.brace.square.js']
      expect(tokens[1]).toEqual value: '/', scopes: ['source.js', 'string.regexp.js', 'punctuation.definition.string.begin.js']
      expect(tokens[2]).toEqual value: 'test', scopes: ['source.js', 'string.regexp.js']
      expect(tokens[3]).toEqual value: '/', scopes: ['source.js', 'string.regexp.js', 'punctuation.definition.string.end.js']
      expect(tokens[4]).toEqual value: ']', scopes: ['source.js', 'meta.brace.square.js']

      {tokens} = grammar.tokenizeLine('[1, /test/]')
      expect(tokens[0]).toEqual value: '[', scopes: ['source.js', 'meta.brace.square.js']
      expect(tokens[1]).toEqual value: '1', scopes: ['source.js', 'constant.numeric.js']
      expect(tokens[2]).toEqual value: ',', scopes: ['source.js', 'meta.delimiter.object.comma.js']
      expect(tokens[3]).toEqual value: ' ', scopes: ['source.js', 'string.regexp.js']
      expect(tokens[4]).toEqual value: '/', scopes: ['source.js', 'string.regexp.js', 'punctuation.definition.string.begin.js']
      expect(tokens[5]).toEqual value: 'test', scopes: ['source.js', 'string.regexp.js']
      expect(tokens[6]).toEqual value: '/', scopes: ['source.js', 'string.regexp.js', 'punctuation.definition.string.end.js']
      expect(tokens[7]).toEqual value: ']', scopes: ['source.js', 'meta.brace.square.js']

      {tokens} = grammar.tokenizeLine('0x1D306')
      expect(tokens[0]).toEqual value: '0x1D306', scopes: ['source.js', 'constant.numeric.js']

      {tokens} = grammar.tokenizeLine('0X1D306')
      expect(tokens[0]).toEqual value: '0X1D306', scopes: ['source.js', 'constant.numeric.js']

      {tokens} = grammar.tokenizeLine('0b011101110111010001100110')
      expect(tokens[0]).toEqual value: '0b011101110111010001100110', scopes: ['source.js', 'constant.numeric.js']

      {tokens} = grammar.tokenizeLine('0B011101110111010001100110')
      expect(tokens[0]).toEqual value: '0B011101110111010001100110', scopes: ['source.js', 'constant.numeric.js']

      {tokens} = grammar.tokenizeLine('0o1411')
      expect(tokens[0]).toEqual value: '0o1411', scopes: ['source.js', 'constant.numeric.js']

      {tokens} = grammar.tokenizeLine('0O1411')
      expect(tokens[0]).toEqual value: '0O1411', scopes: ['source.js', 'constant.numeric.js']

  describe "operators", ->
    it "tokenizes void correctly", ->
      {tokens} = grammar.tokenizeLine('void')
      expect(tokens[0]).toEqual value: 'void', scopes: ['source.js', 'keyword.operator.js']

    it "tokenizes the / arithmetic operator when separated by newlines", ->
      lines = grammar.tokenizeLines """
        1
        / 2
      """

      expect(lines[0][0]).toEqual value: '1', scopes: ['source.js', 'constant.numeric.js']
      expect(lines[1][0]).toEqual value: '/ ', scopes: ['source.js']
      expect(lines[1][1]).toEqual value: '2', scopes: ['source.js', 'constant.numeric.js']

  describe "Properties", ->
    it "tokenizes properties", ->
      {tokens} = grammar.tokenizeLine('obj.prop1.prop2.prop3')
      expect(tokens[2]).toEqual value: 'prop1', scopes: ['source.js', 'entity.name.property.js']
      expect(tokens[4]).toEqual value: 'prop2', scopes: ['source.js', 'entity.name.property.js']
      expect(tokens[6]).toEqual value: 'prop3', scopes: ['source.js', 'entity.name.property.js']

  describe "Functions", ->
    it "tokenizes functions", ->
      {tokens} = grammar.tokenizeLine('function f(){}')
      expect(tokens[0]).toEqual value: 'function', scopes: ['source.js', 'meta.function.js', 'storage.type.function.js']
      expect(tokens[2]).toEqual value: 'f', scopes: ['source.js', 'meta.function.js', 'entity.name.function.js']
    it "tokenizes async functions", ->
      {tokens} = grammar.tokenizeLine('async function f(){}')
      expect(tokens[0]).toEqual value: 'async', scopes: ['source.js', 'meta.function.js', 'storage.modifier.js']
      expect(tokens[2]).toEqual value: 'function', scopes: ['source.js', 'meta.function.js', 'storage.type.function.js']
      expect(tokens[4]).toEqual value: 'f', scopes: ['source.js', 'meta.function.js', 'entity.name.function.js']
    it "tokenizes methods", ->
      {tokens} = grammar.tokenizeLine('f(a, b) {}')
      expect(tokens[0]).toEqual value: 'f', scopes: ['source.js', 'meta.method.js', 'entity.name.function.js']
      expect(tokens[1]).toEqual value: '(', scopes: ['source.js', 'meta.method.js', 'punctuation.definition.parameters.begin.js']
      expect(tokens[2]).toEqual value: 'a', scopes: ['source.js', 'meta.method.js', 'variable.parameter.function.js']
      expect(tokens[4]).toEqual value: 'b', scopes: ['source.js', 'meta.method.js', 'variable.parameter.function.js']
      expect(tokens[5]).toEqual value: ')', scopes: ['source.js', 'meta.method.js', 'punctuation.definition.parameters.end.js']
    it "tokenizes arrows", ->
      {tokens} = grammar.tokenizeLine('a.map((e) => e.value)')
      expect(tokens[2]).toEqual value: 'map', scopes: ['source.js', 'entity.name.property.js']
      expect(tokens[8]).toEqual value: '=>', scopes: ['source.js', 'storage.type.arrow.js']

  describe "ES6 class", ->
    it "tokenizes class", ->
      {tokens} = grammar.tokenizeLine('class MyClass')
      expect(tokens[0]).toEqual value: 'class', scopes: ['source.js', 'meta.class.js', 'storage.type.class.js']
      expect(tokens[2]).toEqual value: 'MyClass', scopes: ['source.js', 'meta.class.js', 'entity.name.type.js']
    it "tokenizes class...extends", ->
      {tokens} = grammar.tokenizeLine('class MyClass extends SomeClass')
      expect(tokens[0]).toEqual value: 'class', scopes: ['source.js', 'meta.class.js', 'storage.type.class.js']
      expect(tokens[2]).toEqual value: 'MyClass', scopes: ['source.js', 'meta.class.js', 'entity.name.type.js']
      expect(tokens[4]).toEqual value: 'extends', scopes: ['source.js', 'meta.class.js', 'storage.modifier.js']
      expect(tokens[6]).toEqual value: 'SomeClass', scopes: ['source.js', 'meta.class.js', 'entity.name.type.js']
    it "tokenizes anonymous class", ->
      {tokens} = grammar.tokenizeLine('class extends SomeClass')
      expect(tokens[0]).toEqual value: 'class', scopes: ['source.js', 'meta.class.js', 'storage.type.class.js']
      expect(tokens[2]).toEqual value: 'extends', scopes: ['source.js', 'meta.class.js', 'storage.modifier.js']
      expect(tokens[4]).toEqual value: 'SomeClass', scopes: ['source.js', 'meta.class.js', 'entity.name.type.js']

  describe "ES6 string templates", ->
    it "tokenizes them as strings", ->
      {tokens} = grammar.tokenizeLine('`hey ${name}`')
      expect(tokens[0]).toEqual value: '`', scopes: ['source.js', 'string.quoted.template.js', 'punctuation.definition.string.begin.js']
      expect(tokens[1]).toEqual value: 'hey ', scopes: ['source.js', 'string.quoted.template.js']
      expect(tokens[2]).toEqual value: '$', scopes: ['source.js', 'string.quoted.template.js', 'source.js.embedded.source', 'punctuation.section.embedded.begin.js']
      expect(tokens[3]).toEqual value: '{', scopes: ['source.js', 'string.quoted.template.js', 'source.js.embedded.source', 'punctuation.section.embedded.js.meta.curly.brace']
      expect(tokens[4]).toEqual value: 'name', scopes: ['source.js', 'string.quoted.template.js', 'source.js.embedded.source']
      expect(tokens[5]).toEqual value: '}', scopes: ['source.js', 'string.quoted.template.js', 'source.js.embedded.source', 'punctuation.section.embedded.js.meta.curly.brace']
      expect(tokens[6]).toEqual value: '`', scopes: ['source.js', 'string.quoted.template.js', 'punctuation.definition.string.end.js']

  describe "ES6 Spread", ->
    it "Tokenizes spreads", ->
      {tokens} = grammar.tokenizeLine('[ ...this.arr ]')
      expect(tokens[0]).toEqual value: '[', scopes: ['source.js', 'meta.brace.square.js']
      expect(tokens[5]).toEqual value: 'this', scopes: ['source.js', 'variable.language.js']
      expect(tokens[7]).toEqual value: 'arr', scopes: ['source.js', 'entity.name.property.js']
      expect(tokens[9]).toEqual value: ']', scopes: ['source.js', 'meta.brace.square.js']

  describe "ES6 import", ->
    it "Tokenizes import ... as", ->
      {tokens} = grammar.tokenizeLine('import \'react\' as React')
      expect(tokens[0]).toEqual value: 'import', scopes: ['source.js', 'meta.import.js', 'keyword.control.js']
      expect(tokens[6]).toEqual value: 'as', scopes: ['source.js', 'meta.import.js', 'keyword.control.js']
    it "Tokenizes import ... from", ->
      {tokens} = grammar.tokenizeLine('import React from \'react\'')
      expect(tokens[0]).toEqual value: 'import', scopes: ['source.js', 'meta.import.js', 'keyword.control.js']
      expect(tokens[4]).toEqual value: 'from', scopes: ['source.js', 'meta.import.js', 'keyword.control.js']
      {tokens} = grammar.tokenizeLine('import {React} from \'react\'')
      expect(tokens[0]).toEqual value: 'import', scopes: ['source.js', 'meta.import.js', 'keyword.control.js']
      expect(tokens[6]).toEqual value: 'from', scopes: ['source.js', 'meta.import.js', 'keyword.control.js']

  describe "ES6 yield", ->
    it "Tokenizes yield", ->
      {tokens} = grammar.tokenizeLine('yield next')
      expect(tokens[0]).toEqual value: 'yield', scopes: ['source.js', 'meta.control.yield.js', 'keyword.control.js']
    it "Tokenizes yield*", ->
      {tokens} = grammar.tokenizeLine('yield * next')
      expect(tokens[0]).toEqual value: 'yield', scopes: ['source.js', 'meta.control.yield.js', 'keyword.control.js']
      expect(tokens[2]).toEqual value: '*', scopes: ['source.js', 'meta.control.yield.js', 'storage.modifier.js']

  describe "default: in a switch statement", ->
    it "tokenizes it as a keyword", ->
      {tokens} = grammar.tokenizeLine('default: ')
      expect(tokens[0]).toEqual value: 'default', scopes: ['source.js', 'keyword.control.js']

  it "tokenizes /* */ comments", ->
    {tokens} = grammar.tokenizeLine('/**/')

    expect(tokens[0]).toEqual value: '/*', scopes: ['source.js', 'comment.block.js', 'punctuation.definition.comment.js']
    expect(tokens[1]).toEqual value: '*/', scopes: ['source.js', 'comment.block.js', 'punctuation.definition.comment.js']

    {tokens} = grammar.tokenizeLine('/* foo */')

    expect(tokens[0]).toEqual value: '/*', scopes: ['source.js', 'comment.block.js', 'punctuation.definition.comment.js']
    expect(tokens[1]).toEqual value: ' foo ', scopes: ['source.js', 'comment.block.js']
    expect(tokens[2]).toEqual value: '*/', scopes: ['source.js', 'comment.block.js', 'punctuation.definition.comment.js']

  it "tokenizes /** */ comments", ->
    {tokens} = grammar.tokenizeLine('/***/')

    expect(tokens[0]).toEqual value: '/**', scopes: ['source.js', 'comment.block.documentation.js', 'punctuation.definition.comment.js']
    expect(tokens[1]).toEqual value: '*/', scopes: ['source.js', 'comment.block.documentation.js', 'punctuation.definition.comment.js']

    {tokens} = grammar.tokenizeLine('/** foo */')

    expect(tokens[0]).toEqual value: '/**', scopes: ['source.js', 'comment.block.documentation.js', 'punctuation.definition.comment.js']
    expect(tokens[1]).toEqual value: ' foo ', scopes: ['source.js', 'comment.block.documentation.js']
    expect(tokens[2]).toEqual value: '*/', scopes: ['source.js', 'comment.block.documentation.js', 'punctuation.definition.comment.js']

  describe "indentation", ->
    editor = null

    beforeEach ->
      editor = new TextEditor({})
      editor.setGrammar(grammar)

    expectPreservedIndentation = (text) ->
      editor.setText(text)
      editor.autoIndentBufferRows(0, editor.getLineCount() - 1)

      expectedLines = text.split("\n")
      actualLines = editor.getText().split("\n")
      for actualLine, i in actualLines
        expect([
          actualLine,
          editor.indentLevelForLine(actualLine)
        ]).toEqual([
          expectedLines[i],
          editor.indentLevelForLine(expectedLines[i])
        ])

    it "indents allman-style curly braces", ->
      expectPreservedIndentation """
        if (true)
        {
          for (;;)
          {
            while (true)
            {
              x();
            }
          }
        }
        else
        {
          do
          {
            y();
          } while (true);
        }
      """

    it "indents non-allman-style curly braces", ->
      expectPreservedIndentation """
        if (true) {
          for (;;) {
            while (true) {
              x();
            }
          }
        } else {
          do {
            y();
          } while (true);
        }
      """

    it "indents collection literals", ->
      expectPreservedIndentation """
        [
          {
            a: b,
            c: d
          },
          e,
          f
        ]
      """

    it "indents function arguments", ->
      expectPreservedIndentation """
        f(
          g(
            h,
            i
          ),
          j
        );
      """
