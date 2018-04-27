# Load color definitions
[ -e ~/.bashrc.d/inc/named_colors.sh ] && . ~/.bashrc.d/inc/named_colors.sh

cores=$(awk '/cpu cores/ { print $4; exit }' /proc/cpuinfo)

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
	avg_1m=$(awk "BEGIN {print ${avg[0]} * 100}")

	if [ "$avg_1m" -ge $(( 100 * $cores )) ]; then # Alarm state
		avg_str=$ASC
	elif [ "$avg_1m" -gt $(( 70 * $cores )) ]; then # Warning state
		avg_str=$SEC
	fi
	avg_str+=${avg[*]}

	printf "$FMT" "$RAM_str" "$avg_str"

	# Set the PS1 prompt (with colors).
	PS1='${DPC}[${AXC}\l \j \!${DPC}]\n'

	PS1+='${DPC}['
	if [ -d ".git" ]; then
		PS1+=$(git_user_prompt)
	else
		PS1+='${PRC}\u${DPC}@${AXC}\H'
	fi
	PS1+='${DPC}]'

	PS1+='\n${AXC}\w/\n'
	[ -d ".git" ] && PS1+='\[${DPC}\]('$(git_branch_prompt)'\[${DPC}\]) '
	PS1+='\[$(out=$?; test $out -eq 0 && echo ${DPC} || echo ${ASC}; exit $out)\]$? '
	PS1+='\[${AXC}\]\$ :\[$RES\] '
}

