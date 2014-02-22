__ghetto_gitdir ()
{
  if [ -z "${1-}" ]; then
    if [ -n "${__git_dir-}" ]; then
      echo "$__git_dir"
    elif [ -n "${GIT_DIR-}" ]; then
      test -d "${GIT_DIR-}" || return 1
      echo "$GIT_DIR"
    elif [ -d .git ]; then
      echo .git
    else
      git rev-parse --git-dir 2>/dev/null
    fi
  elif [ -d "$1/.git" ]; then
    echo "$1/.git"
  else
    echo "$1"
  fi
}

__ghetto_git_heads ()
{
  local dir="$(__ghetto_gitdir)"
  if [ -d "$dir" ]; then
    git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
      refs/heads
    return
  fi
}

__ghetto_gitcomp ()
{
  emulate -L zsh

  local cur_="${3-$cur}"

  case "$cur_" in
    --*=)
      ;;
    *)
      local c IFS=$' \t\n'
      local -a array
      for c in ${=1}; do
        c="$c${4-}"
        case $c in
          --*=*|*.) ;;
        *) c="$c " ;;
      esac
      array+=("$c")
    done
    compset -P '*[=:]'
    compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
    ;;
esac
}

_git-workflow() {
  prefix=$(echo $words | awk 'match($0, /(-p|--prefix) +(\w+)/, a) {print a[2]}')
  separator=$(echo $words | awk 'match($0, /(-s|--separator) +(\w+)/, a) {print a[2]}')

  if [ -z "$separator"]; then
    separator="/"
  fi

  query="$prefix$separator"

  __ghetto_gitcomp  "$(__ghetto_git_heads | grep "^$query" | sed -e 's/[]\/()$*.^|[]//g' | sed s/$prefix//g)"
}
