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
  prefix=`echo $words | awk 'match($0, /(-p|--prefix) +(.+)/, a) {print a[2]}'`
  branches=`git branch --all | grep -v "\*" | tr -d ' ' | grep ^$prefix`
  __ghetto_gitcomp  "$branches"
}
