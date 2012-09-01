# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# use menu seletion for arrow key navigation and highlighting
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''
