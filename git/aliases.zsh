# Make git more awesome (if that's even possible)
# Inspired by @holman's git-related dotfile and his
# awesome "Git and GitHub Secrets" talk.
alias g='git'
alias gcd='cd "`git rev-parse --show-toplevel`"'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
