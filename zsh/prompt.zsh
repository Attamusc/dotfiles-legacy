autoload colors && colors

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[ "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$fg_bold[blue]%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=": %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=": %{$fg[green]%}✔"

# Colors vary depending on time lapsed.
# The following is based on @pengwynn's dotfiles
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[cyan]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg_bold[white]%}"

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
# Shamelessly taken from @pengwynn
function git_time_since_commit() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    # Only proceed if there is actually a commit.
    if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
      # Get the last commit.
      last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
      now=`date +%s`
      seconds_since_last_commit=$((now-last_commit))

      # Totals
      MINUTES=$((seconds_since_last_commit / 60))
      HOURS=$((seconds_since_last_commit/3600))

      # Sub-hours and sub-minutes
      DAYS=$((seconds_since_last_commit / 86400))
      SUB_HOURS=$((HOURS % 24))
      SUB_MINUTES=$((MINUTES % 60))

      if [[ -n $(git status -s 2> /dev/null) ]]; then
          if [ "$MINUTES" -gt 60 ]; then
              COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
          elif [ "$MINUTES" -gt 30 ]; then
              COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
          else
              COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
          fi
      else
          COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
      fi

      if [ "$HOURS" -gt 24 ]; then
          echo " $COLOR${DAYS}d "
      elif [ "$MINUTES" -gt 60 ]; then
          echo " $COLOR${HOURS}h${SUB_MINUTES}m "
      else
          echo " $COLOR${MINUTES}m "
      fi
    else
      COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
      echo "$COLOR"
    fi
  fi
}

# From @pengwynn's awwwwesome dotfiles :D
function notes_count() {
  if [[ -z $1 ]]; then
    local NOTES_PATTERN="TODO|FIXME|HACK";
  else
    local NOTES_PATTERN=$1;
  fi
  grep -ERn "\b($NOTES_PATTERN)\b" {app,config,lib,spec,test,src,main} 2>/dev/null | wc -l | sed 's/ //g'
}

function notes_prompt() {
  local COUNT=$(notes_count $1);
  if [ $COUNT != 0 ]; then
    echo " $1: $COUNT";
  else
    echo "";
  fi
}

set_prompt () {
  export PROMPT='%{$fg[cyan]%}%c $(git_prompt_info)$(git_time_since_commit)%{$fg_bold[red]%}$ %{$reset_color%}'
  export RPROMPT="%{$fg_bold[blue]%}$(notes_prompt TODO)%{$reset_color%}%{$fg_bold[yellow]%}$(notes_prompt HACK)%{$reset_color%}%{$fg_bold[red]%}$(notes_prompt FIXME)%{$reset_color%}"
}

precmd() {
  title "zsh" "%c" "%55<...<%~"
  set_prompt
}
