# Add direnv
if which direnv > /dev/null; then eval eval "$(direnv hook zsh)"; fi

# Add rbenv
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

# Add tmuxifier
if which tmuxifier > /dev/null; then eval "$(tmuxifier init -)"; fi

if [[ -d "/home/linuxbrew/.linuxbrew" ]]
then
  export PATH=$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# If we have linux brew, add it to the path
[ -d "/home/linuxbrew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
