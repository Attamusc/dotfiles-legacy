# Dotfiles

Dotfiles are how you personalize your machine; these are mine. If you like them, feel free to use them or modify them to your own preferences.

## Components

The topics are fairly opinionated, with only the stuff I actually use included. This currently includes the following:

* OS X
* ZSH
* Git
* Ruby
* Node.js
* JVM (Java, Scala, Clojure)
* PostgreSQL
* Homebrew
* Vim
* Sublime Text 2

## Organization

The files are split by topic, instead of lumped into massive files with different sections. I tend to be indecisive with my configurations, so I change stuff often; this setup makes it easy for me to change things quickly, as well as easily being able to see what deals with what.

## Install

To install, run `script/bootstrap`, which will link up all the necessary files. If on OS X, the `bin/dot` script with be run to set some defaults and install homebrew packages (take a look at `brew/install.sh` to see what gets installed). Run this every once-in-while to get the latest and greatest from homebrew.

There are also <code>*-install.sh</code> for a few package managers which will install global packages I like or use a lot. Currently there is an `npm` one in `/node` and a `gem` one in `/ruby`. **NOTE:** These do not get run in the bootstrap script, as they may not be for everyone.
## Thanks

Lots of the little tricks and settings in these files came either from or were inspired by various other's dotfiles, including [Zach Holman](https://github.com/holman/dotfiles), [Ryan Bates](https://github.com/ryanb/dotfiles), [Mathias Bynens](https://github.com/mathiasbynens/dotfiles), [Ryan Tomayko](https://github.com/rtomayko/dotfiles), and [Wynn Netherland](https://github.com/pengwynn/dotfiles). You guys **rock**.

## License

The MIT License

Copyright (c) Sean Dunn, http://www.attamusc.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

