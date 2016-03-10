# Exports
# Fix for cgo on Mavericks
export CC=clang

export EDITOR="mvim"
export LESS=FRSX

# Languages
export PHP_HOME=$(brew --prefix php56)
export GO_HOME=$(brew --prefix go)/libexec
export COMPOSER_HOME=/Users/atta/.composer

export GOPATH=~/Projects/go-space

# Frameworks
export ACTIVATOR_HOME=/usr/local/opt/typesafe-activator

# Tools
export BEES_HOME=/usr/local/cloudbees-sdk-0.7.1
export GRADLE_HOME=/usr/local/gradle-1.0-milestone-6
export POSTGRES_APP_HOME=/Applications/Postgres.app/Contents/Versions/9.3
export TMUXIFIER_HOME=~/.tmuxifier
export HEROKU_HOME=/usr/local/heroku

# Set up our default PATH variable
export PATH=$HOME/.dotfiles/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# Add our special directories
export PATH=$PHP_HOME/bin:$HEROKU_HOME/bin:$TMUXIFIER_HOME/bin:$GOPATH/bin:$GO_HOME/bin:$POSTGRES_APP_HOME/bin:$ACTIVATOR_HOME/bin:$GRADLE_HOME/bin:$BEES_HOME:$COMPOSER_HOME/vendor/bin:$PATH

# Add direnv
if which direnv > /dev/null; then eval eval "$(direnv hook zsh)"; fi

# Add rbenv
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

# Add tmuxifier
if which tmuxifier > /dev/null; then eval "$(tmuxifier init -)"; fi

# Load nvm shims
nvm ls default &>/dev/null && nvm use default &>/dev/null

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# Set our MANPATH for `man`
export MANPATH="/usr/share/man:/share/man:/usr/local/mysql/man:$MANPATH"
