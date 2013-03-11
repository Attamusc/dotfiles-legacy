# Wrap git with hub
if [[ -f `command -v hub` ]] ; then alias git=hub ; fi

function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status --short --branch
  fi
}
