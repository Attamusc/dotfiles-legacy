# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"
alias cdot="cd $HOME/.dotfiles"

# Shortcuts
alias m="mvim"
alias v="vim"
alias o="open"
alias oo="open ."

# Open Mou from the command line
alias md="open -a Mou"

# ls
alias l="exa -lah"
alias ll="exa -l"
alias la='exa -a'
alias kl="k --almost-all"

# ---Spotlight Stuff---
# Disable/Enable spotlight indexing
alias spotoff="sudo mdutil -a -i off"
alias spoton="sudo mdutil -a -i on"
# Hide/Show spotlight menubar icon
alias spothide='sudo mv /System/Library/CoreServices/Search.bundle /System/Library/CoreServices/Search.bundle.bak && killall SystemUIServer'
alias spotshow='sudo mv /System/Library/CoreServices/Search.bundle.bak /System/Library/CoreServices/Search.bundle && killall SystemUIServer'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Short webkit2png - don't want to add it to the PATH...
alias w2p='/usr/local/Cellar/webkit2png/0.5/bin/webkit2png'

# Map HTTP verbs to use @visionmedia's awesome
# burl utility
alias GET='burl GET'
alias HEAD='burl -I'
alias POST='burl POST'
alias PUT='burl PUT'
alias PATCH='burl PATCH'
alias DELETE='burl DELETE'
alias OPTIONS='burl OPTIONS'
