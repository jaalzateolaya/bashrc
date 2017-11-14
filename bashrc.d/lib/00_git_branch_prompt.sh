# Load color definitions
[ -e ~/.bashrc.d/inc/named_colors.sh ] && . ~/.bashrc.d/inc/named_colors.sh

# Prints the git username, email and current branch
git_branch_prompt () {
	local bn=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	local un=$(git config user.name)
	local ue=$(git config user.email)
	local clr=""

	if [ "$bn" = "master" ]; then
		clr=${ASC}
	elif [ -z "${bn##devel*}" ]; then
		clr=${SEC}
	else
		clr=${AXC}
	fi

	echo -n "${DPC}[${PRC}${un} ${DPC}<${AXC}${ue}${DPC}>${DPC}]"
	echo " (${PRC}Branch: ${clr}${bn}${DPC})"
}

