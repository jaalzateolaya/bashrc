#
# Completion for git:
#
# git [command]
# git branch (options) [branch]
# git checkout (options) [branch]
# git merge (options) [branch]
# git rebase (options) [branch]

_git ()
{
	local cur prev opts

	if ! git status &>/dev/null; then
		return 0
	fi

	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[COMP_CWORD - 1]}

	if [ "$prev" = "git" ]; then
		opts=$( find /usr/lib/git-core -executable | sed 's/.*git-//g' )
	else
		case "${COMP_WORDS[1]}" in
			branch|checkout|merge|rebase)
				opts=$( git branch --format '%(refname:short)' )
				;;
		esac
	fi


	COMPREPLY=( $( compgen -W "$opts" -- $cur ) )

	return 0
}

complete -o bashdefault -o default -F _git git

