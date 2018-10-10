#
# Completion for git:
#
# git checkout [branch]

_git ()
{
	local cur prev

	if ! git status &>/dev/null; then
		return 0
	fi

	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[COMP_CWORD - 1]}

	case "$prev" in
		checkout)
			local branches=$( git branch --format '%(refname:short)' | paste -sd ' ' )
			COMPREPLY=( $( compgen -W "$branches" -- $cur ) )
			;;
		add)
			COMPREPLY=( $( compgen -W "" ) )
	esac

	return 0
}

complete -o bashdefault -o default -F _git git

