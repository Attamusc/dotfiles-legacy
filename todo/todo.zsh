alias t='`brew --prefix`/bin/todo.sh -c -d $HOME/.todo.cfg'
alias n='t ls +next'

_t() {
  local _todo_sh='`brew --prefix`/bin/todo.sh -d "$HOME/.todo.cfg"'
  _todo.sh "$@"
}

