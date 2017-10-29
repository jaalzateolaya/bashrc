# Set the PS1 prompt (with colors).
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*|screen*)
		PRC=$(tput setaf 33)  # Primary Color
		DPC=$(tput setaf 27)  # Dark Primary Color
		LPC=$(tput setaf 39)  # Light Primary Color
		SEC=$(tput setaf 130) # Secondary Color (Orange)
		ASC=$(tput setaf 160) # Ascent Color (Red)
		AXC=$(tput setaf 246) # Auxiliary Color (Gray)
		RES=$(tput sgr0)      # Reset
		;;
	*)
		PRC=$(tput setaf 2) # Primary Color
		DPC=$(tput setaf 4) # Dark Primary Color
		LPC=$(tput setaf 3) # Light Primary Color
		SEC=$(tput setaf 5) # Secondary Color (Orange)
		ASC=$(tput setaf 1) # Ascent Color (Red)
		AXC=$(tput setaf 6) # Auxiliary Color (Gray)
		RES=$(tput sgr0)    # Reset
		;;
esac

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

prompt_command () {
	local FMT="\n${PRC}Free RAM: %b%% ${PRC}Load AVG: %b${RES} "

	local avg=( $(awk '{ print $1, $2, $3 }' /proc/loadavg) )
	local free_RAM=$(awk '
			/MemAvailable/ { a = $2 }
			/MemTotal/ { t = $2 }
			END { printf "%d", 100 * a / t }
		' /proc/meminfo)

	RAM_str=$LPC
	if [ "$free_RAM" -le 15 ]; then
		RAM_str=$ASC
	elif [ "$free_RAM" -lt 40 ]; then
		RAM_str=$SEC
	fi
	RAM_str+=$free_RAM

	avg_str=$LPC
	avg_1m=$(awk "BEGIN {print ${avg[0]}}")
	avg_1m=${avg_1m%.*}

	if [ "$avg_1m" -ge 85 ]; then
		avg_str=$ASC
	elif [ "$avg_1m" -gt 60 ]; then
		avg_str=$SEC
	fi
	avg_str+=${avg[*]}

	printf "$FMT" "$RAM_str" "$avg_str"

	PS1='${DPC}[${AXC}\l \j \!${DPC}]\n'
	PS1+='${LPC}\t \d '
	PS1+='${AXC}\w/\n'

	if [ -d ".git" ]; then
		PS1+=$(git_branch_prompt)
	else
		PS1+='${DPC}[${PRC}\u${DPC}@${AXC}\H${DPC}]'
	fi

	PS1+='\n${ASC}$? '
	PS1+='${AXC}\$ :$RES '
}

PROMPT_COMMAND='prompt_command'

# Set the default editor to vim.
export EDITOR=vim

# Avoid succesive duplicates in the bash command history.
export HISTCONTROL=ignoredups

# Append commands to the bash command history file (~/.bash_history)
# instead of overwriting it.
shopt -s histappend

# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
#PROMPT_COMMAND='history -a'

# Add bash aliases.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

setxkbmap -layout es 2>/dev/null

