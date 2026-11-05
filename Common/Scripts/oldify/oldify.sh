#!/usr/bin/env bash

# Most smallest script ever just renaming files given in as arguments to the same name but appended with .old

#TODO:
# - Flag for interactive usage
# - Flag for unolding files.

for var in "$@"
do
	if [ -e "$var" ]; then
		if [ -e "$var.old" ]; then
			echo "$var.old already found. Oldifying that one first."
			oldify "$var.old"
		fi
		echo "Oldifying $var..."
		mv "$var" "$var.old"
	else
		echo "ERROR: Couldn't find $var."
	fi
done
