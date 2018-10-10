# Sources a folder
source_folder () {
	local folder=$1

	if [ -d "$folder" ]; then
		for file in "$folder"/*.sh; do
			test -r "$file" && . "$file"
		done
	fi
}

# Append commands to the bash command history file (~/.bash_history)
# instead of overwriting it.
shopt -s histappend

# Load env
source_folder ~/.bashrc.d/env

# Load lib
source_folder ~/.bashrc.d/lib

# Load aliases
source_folder ~/.bashrc.d/aliases

setxkbmap -layout es 2>/dev/null

