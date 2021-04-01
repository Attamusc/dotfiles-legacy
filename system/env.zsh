# Homebrew
# if we're using linuxbrew, then setup some special vars
if [[ -d "/home/linuxbrew/.linuxbrew" ]]
then
  export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
  export HOMEBREW_CELLAR=$HOMEBREW_PREFIX/Cellar
  export HOMEBREW_REPOSITORY=$HOMEBREW_PREFIX/Homebrew
fi

# Fix for cgo on Mavericks
export CC=clang

# Make sure colors work in neovim in tmux
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Additional options for tmuxifier to call tmux with
# -2 forces tmux into 256 color mode
export TMUXIFIER_TMUX_OPTS="-2"

export EDITOR="nvim"
export LESS=iRS
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS='--height 40% --reverse'

export USER_BIN=$HOME/bin

# Languages
export GO_HOME=$(brew --prefix go)/libexec
export COMPOSER_HOME=$HOME/.composer
export CARGO_HOME=$HOME/.cargo
# export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src

export GOPATH=$PROJECTS/go-space

# Frameworks
export ACTIVATOR_HOME=/usr/local/opt/typesafe-activator

# Tools
export BEES_HOME=/usr/local/cloudbees-sdk-0.7.1
export GRADLE_HOME=/usr/local/gradle-1.0-milestone-6
export POSTGRES_APP_HOME=/Applications/Postgres.app/Contents/Versions/latest
export TMUXIFIER_HOME=~/.tmuxifier
export HEROKU_HOME=/usr/local/heroku
export GIT_FUZZY_HOME=~/Projects/Tools/git-fuzzy
export VOLTA_HOME="$HOME/.volta"
export YARN_HOME="$HOME/.yarn"

# Set up our default PATH variable
export PATH=$HOME/.local/bin:$HOME/.dotfiles/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# Add our special directories
export PATH=$USER_BIN:$VOLTA_HOME/bin:$YARN_HOME/bin:$HEROKU_HOME/bin:$TMUXIFIER_HOME/bin:$GOPATH/bin:$GO_HOME/bin:$POSTGRES_APP_HOME/bin:$ACTIVATOR_HOME/bin:$GRADLE_HOME/bin:$BEES_HOME:$COMPOSER_HOME/vendor/bin:$CARGO_HOME/bin:$GIT_FUZZY_HOME/bin:$PATH

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:.git/safe/../../node_modules/.bin:$PATH"


# Set our MANPATH for `man`
export MANPATH="/usr/share/man:/share/man:/usr/local/mysql/man:$MANPATH"
