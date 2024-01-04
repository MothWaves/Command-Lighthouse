#!/usr/bin/env sh

# A very minimalist string comparison script. 

if [ $# -ne 2 ]; then
    echo "Please provide 2 strings for comparison"
    exit -1
fi

STR1="$1"
STR2="$2"

if [ "$STR1" = "$STR2" ]; then
    echo "Strings are equal."
    exit 0
else
    echo "Strings are not equal."
    exit 1
fi
