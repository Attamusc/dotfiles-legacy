# Inspired by @holman's git-related dotfiles and his
# awesome "Git and GitHub Secrets" talk.
alias gcd='cd "`git rev-parse --show-toplevel`"'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gf='git fuzzy'
