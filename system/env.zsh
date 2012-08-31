# Exports
# make Sublime the default editor
export EDITOR="subl"

export BEES_HOME=/usr/local/cloudbees-sdk-0.7.1
export GWT_HOME=/usr/local/gwt-2.4.0
export GRAILS_HOME=/usr/local/grails-2.0.0
export GRADLE_HOME=/usr/local/gradle-1.0-milestone-6
export GROOVY_HOME=/usr/local/Cellar/groovy/1.8.0/libexec
export PLAY_HOME=/Applications/play-2.0
export DART_HOME=/Users/Atta/dart/dart-sdk
export POSTGRES_APP_HOME=/Applications/Postgres.app/Contents/MacOS

# Set up our default PATH variable
export PATH=$HOME/.dotfiles/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# Add our special directories
export PATH=$PATH:$POSTGRES_APP_HOME/bin:$DART_HOME/bin:$PLAY_HOME:$GROOVY_HOME:$GRADLE_HOME/bin:$GRAILS_HOME/bin:$GWT_HOME:$BEES_HOME

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Set our MANPATH for `man`
export MANPATH="/usr/share/man:/share/man:/usr/local/mysql/man:$MANPATH"
