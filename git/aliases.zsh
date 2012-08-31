# Make git more awesome (if that's even possible)
# Inspired by @holman's git-related dotfile and his
# awesome "Git and GitHub Secrets" talk.
alias gpull='git pull --prune'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push'
alias gpom='git push origin master'
alias gph='git push origin HEAD'
alias gdi='git diff'
alias gad='git add .'
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gm='git merge --no-ff'
alias gbr='git branch'
alias gs='git status -sb'
alias gcd='cd "`git rev-parse --show-toplevel`"'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
