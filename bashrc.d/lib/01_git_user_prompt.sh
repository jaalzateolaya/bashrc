# Load color definitions
[ -e ~/.bashrc.d/inc/named_colors.sh ] && . ~/.bashrc.d/inc/named_colors.sh

# Prints the git username and email.
git_user_prompt () {
	local un=$(git config user.name)
	local ue=$(git config user.email)

	echo -n "${PRC}${un} ${DPC}<${AXC}${ue}${DPC}>${DPC}"
}

