#
# Completion for git:
#
# git checkout [branch]

_git ()
{
	local cur prev opts

	if ! git status &>/dev/null; then
		return 0
	fi

	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[COMP_CWORD - 1]}

	case "$prev" in
		git)
			opts=$( find /usr/lib/git-core -executable | sed 's/.*git-//g' )
			;;
		checkout)
			opts=$( git branch --format '%(refname:short)' )
			;;
	esac

	COMPREPLY=( $( compgen -W "$opts" -- $cur ) )

	return 0
}

complete -o bashdefault -o default -F _git git

