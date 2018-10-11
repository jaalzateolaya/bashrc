#
# Completion for npm:
#
# npm run [npm-script]

_npm ()
{
	local cur prev opts

	if [ ! -f 'package.json' ]; then
		return 0
	fi

	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[COMP_CWORD - 1]}

	case "$prev" in
		run)
			opts=$( awk '/scri.*{/,/}/{if(match($0,/"([^"]*)": "/,m)){print m[1]}}' package.json )
			;;
	esac

	COMPREPLY=( $( compgen -W "$opts" -- $cur ) )

	return 0
}

complete -o bashdefault -o default -F _npm npm

