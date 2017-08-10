#!/usr/bin/bash

DIR=$( dirname $( dirname "${BASH_SOURCE[0]}") )

announce () {
	echo $(date +%c): ${1}...
}

for i in $DIR/bash*; do
	i=$(basename $i)
	announce "Installing $i";
	install -m 0600 {$DIR/,$HOME/.}$i
done

announce "Finished!"

