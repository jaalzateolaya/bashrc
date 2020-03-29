# Load color definitions
[ -e ~/.bashrc.d/inc/named_colors.sh ] && . ~/.bashrc.d/inc/named_colors.sh

# Prints the git current branch.
git_branch_prompt () {
	local bn=$(git_branch_prompt_name)
	local clr=""

	if [ -z "${bn##prod*}" ]; then
		clr=${ASC}
	elif [ "$bn" = "master" ]; then
		clr=${SEC}
	elif [ -z "${bn##*/*}" ]; then
		clr=${LPC}
	else
		clr=${AXC}
	fi

	echo -n "\[${clr}\]${bn}\[${DPC}\]"
}

git_branch_prompt_name () {
	local bn=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

	if [ ${#bn} -gt 30 ]; then
		bn=${bn:0:27}...
	fi

	echo $bn
}

