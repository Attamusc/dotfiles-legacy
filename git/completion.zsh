# Uses git's autocompletion for inner commands. Assumes an install of git's
# bash `git-completion` script at $completion below (this is where Homebrew
# tosses it, at least).
# Also, reference the completions for @visionmedia's git-extras
completion=/usr/local/etc/bash_completion.d/git-completion.bash
git_extras_completions=/etc/bash_completion.d/git-extras

if test -f $completion
then
  source $completion
fi

if test -f $git_extras_completions
then
  source $git_extras_completions
fi
