#!/usr/bin/env sh

# Update brew
brew update

# Upgrade installed formulas
brew upgrade

# ---"TEH NECESSARIES"---
brew install coreutils
brew install grc
brew install ack
brew install tree
brew install webkit2png
brew install git
brew install hub

# ---Languages---
# Node.js
# the brew node does not install npm, but it can be installed with the following:
# curl http://npmjs.org/install.sh | sh
# Removing this for now, since we use @visionmedia's n to manage our node installs
# brew install node

# Scala and Typesafe Stack
brew install scala
brew install sbt
brew install maven
brew install giter8

# Clojure
brew install clojure
brew install leiningen

# Inform that npm should be installed
echo 'Hey Buddy! You may want to install npm: "curl http://npmjs.org/install.sh | sh"'
