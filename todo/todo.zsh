alias t='`brew --prefix`/bin/todo.sh -c -d $HOME/.todo.cfg'
alias tl='t ls'
alias tn='t ls +next'

_t() {
  local _todo_sh='`brew --prefix`/bin/todo.sh -d "$HOME/.todo.cfg"'
  _todo.sh "$@"
}

