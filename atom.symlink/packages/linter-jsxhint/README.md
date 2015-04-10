# [linter-jsxhint](https://atom.io/packages/linter-jsxhint)

This linter plugin for [Linter](https://github.com/AtomLinter/Linter) provides an interface to [jsxhint](https://github.com/STRML/JSXHint). It will be used with files that have the “JSX” syntax.

## Installation
Linter package must be installed in order to use this plugin. If Linter is not installed, please follow the instructions [here](https://github.com/AtomLinter/Linter).

And you should already have the [React Package](https://atom.io/packages/react) in order to have the JSX recognized.

### Plugin installation
```
$ apm install linter-jsxhint
```

## Settings
You can configure linter-jsxhint by editing ~/.atom/config.cson (choose Open Your Config in Atom menu):
```
'linter-jsxhint':
  'jsxhintExecutablePath': null #jsxhint path. run 'which jsxhint' to find the path
```

## Contributing
If you would like to contribute enhancements or fixes, please do the following:

1. Fork the plugin repository.
1. Hack on a separate topic branch created from the latest `master`.
1. Commit and push the topic branch.
1. Make a pull request.
1. welcome to the club

Please note that modifications should follow these coding guidelines:

- Indent is 2 spaces.
- Code should pass coffeelint linter.
- Vertical whitespace helps readability, don’t be afraid to use it.

Thank you for helping out!

## Donation
[![Share the love!](https://chewbacco-stuff.s3.amazonaws.com/donate.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KXUYS4ARNHCN8)
