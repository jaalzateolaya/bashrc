#!/usr/bin/bash

DIR=$( dirname $( dirname "${BASH_SOURCE[0]}") )

announce () {
	echo $(date +%c): ${1}...
}

bashrc_install () {
	[ ! -e "$1" -o -z "$2" ] && return -1;

	local src=$(basename $1)
	local dir=${1%$src}
	local prefix=$3
	local dst="${2}/${prefix}${src}"

	announce "Installing $src";

	if [ -d "$dir/$src" ]; then
		# Create the target directory
		[ ! -d  "$dst" ] && mkdir -m 0700 "$dst"

		for f in $dir/$src/*; do
			bashrc_install $f $dst
		done;
	else
		install -m 0600 "$dir/$src" "$dst"
	fi
}

for i in $DIR/bash*; do
	bashrc_install "$i" "$HOME" "."
done

announce "Finished!"

