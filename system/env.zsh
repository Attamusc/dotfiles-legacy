# Exports
# Fix for cgo on Mavericks
export CC=clang

# make Sublime the default editor
export EDITOR="mvim"
export LESS=FRSX

# Languages
export GROOVY_HOME=/usr/local/Cellar/groovy/1.8.0/libexec
export DART_HOME=/Users/Atta/dart/dart-sdk
export GO_HOME=/usr/local/go

export GOPATH=~/Projects/go-space

# Frameworks
export GWT_HOME=/usr/local/gwt-2.4.0
export GRAILS_HOME=/usr/local/grails-2.0.0
export PLAY_HOME=/usr/local/play

# Tools
export BEES_HOME=/usr/local/cloudbees-sdk-0.7.1
export GRADLE_HOME=/usr/local/gradle-1.0-milestone-6
export POSTGRES_APP_HOME=/Applications/Postgres.app/Contents/MacOS
export TMUXIFIER_HOME=/usr/local/tmuxifier

# Set up our default PATH variable
export PATH=$HOME/.dotfiles/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# Add our special directories
export PATH=$TMUXIFIER_HOME/bin:$GOPATH/bin:$GO_HOME/bin:$POSTGRES_APP_HOME/bin:$DART_HOME/bin:$PLAY_HOME:$GROOVY_HOME:$GRADLE_HOME/bin:$GRAILS_HOME/bin:$GWT_HOME:$BEES_HOME:$PATH

# Add rbenv, if we have/need it
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Add tmuxifier, if we have/need it
if which tmuxifier > /dev/null; then eval "$(tmuxifier init -)" ; fi

# Set our MANPATH for `man`
export MANPATH="/usr/share/man:/share/man:/usr/local/mysql/man:$MANPATH"

# Use the base-16 color override so that we can use it's
# scheme in terminal vim
#source $ZSH/system/colors/base16-eighties.dark.sh
