# Dotfiles

Dotfiles are how you personalize your machine; these are mine. If you like them, feel free to use them or modify them to your own preferences.

## Components

The topics are fairly opinionated, with only the stuff I actually use included. This currently includes the following:

* OS X
* ZSH
* Git
* Ruby
* Node.js
* JVM (Java, Scala, Clojure, Groovy)
* PostgreSQL
* Homebrew
* Sublime Text 2
* (Some) Vim

```
require 'activerecord
class Boy < Person
    attr_accessor :name, :fav_food
```

## Organization

The files are split by topic, instead of lumped into massive files with different sections. I tend to be indecisive with my configurations, so I change stuff often; this setup makes it easy for me to change things quickly, as well as easily being able to see what deals with what.

## Install

The installer is run with `rake install`. Following [Zach Holman's Dotfiles](https://github.com/holman/dotfiles), anything marked `*.symlink` will be linked from the dotfiles repo to your `$HOME` folder. This will not actually install anything, it'll simply move things into the correct spot. The Sublime Text 2 User directory also DOES NOT get moved auto-magically with the install command.

There is a bootstrap script, which I am currently working on, but it HAS NOT BEEN TESTED on a clean machine (because I don't have one :P)

## Thanks

Lots of the little tricks and settings in these files came either from or were inspired by various other's dotfiles, including [Zach Holman](https://github.com/holman/dotfiles), [Ryan Bates](https://github.com/ryanb/dotfiles), [Mathias Bynens](https://github.com/mathiasbynens/dotfiles), [Ryan Tomayko](https://github.com/rtomayko/dotfiles), and [Wynn Netherland](https://github.com/pengwynn/dotfiles). You guys rock.

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

