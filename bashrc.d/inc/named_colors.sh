case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*|screen*)
		PRC=$(tput setaf 33)  # Primary Color
		DPC=$(tput setaf 27)  # Dark Primary Color
		LPC=$(tput setaf 39)  # Light Primary Color
		SEC=$(tput setaf 130) # Secondary Color (Orange)
		ASC=$(tput setaf 202) # Ascent Color (Orange)
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

