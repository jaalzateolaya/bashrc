#!/usr/bin/bash

DIR=$( dirname $( dirname "${BASH_SOURCE[0]}") )

announce () {
	echo $(date +%c): ${1}...
}

for i in $DIR/bash*; do
	i=$(basename $i)
	announce "Installing $i";
	if [ -d "$DIR/$i" ]; then
		# Create the directory
		[ ! -d "$HOME/.$i" ] && mkdir "$HOME/.$i"

		# Copy the directory content
		cp --update --target-directory=$HOME/.$i --recursive $DIR/$i/*

		# Define permissions
		find "$HOME/.$i" -type d -exec chmod 0500 {} \;
		find "$HOME/.$i" -type f -exec chmod 0400 {} \;
	else
		install -m 0600 {$DIR/,$HOME/.}$i
	fi
done

announce "Finished!"

