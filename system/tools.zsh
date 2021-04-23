# Add direnv
if which direnv > /dev/null; then eval eval "$(direnv hook zsh)"; fi

# Add rbenv
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

# Add tmuxifier
if which tmuxifier > /dev/null; then eval "$(tmuxifier init -)"; fi

if [[ -d "/home/linuxbrew/.linuxbrew" ]]
then
  export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH
  
  # If we have linux brew, add it to the path
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Load nvm shims
if which nvm > /dev/null
then
  nvm ls default &>/dev/null && nvm use default &>/dev/null
fi

# Load fzf if it's installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load kubectl completion if it's installed
if which kubectl > /dev/null; then source <(kubectl completion zsh); fi

# tab multiplexer configuration: https://github.com/austinjones/tab-rs/
source "$HOME/Library/Application Support/tab/completion/zsh-history.zsh"
# end tab configuration
