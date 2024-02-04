#!/usr/bin/env python3
import os
import sys

# CHANGE THE CODE AND THEN CHANGE THIS VARIABLE TO EQUAL FALSE. (I'll setup a better system eventually (lmao no I won't))
EXIT_FLAG = True

arguments = sys.argv
if len(arguments) != 2:
    print("Incorrect usage. Please provide the path to rename.")
    print("Remember to change the code to rename the files as desired.")
    exit(-2)
if EXIT_FLAG:
    print("Please change the code.")
    exit(-1)
path = os.fspath(arguments[1])
files = os.listdir(path)

# User confirmation
print("This will rename all files in the following path: ", path)
print("Are you sure you wish to proceed? [y/N]")
if input().lower() != "y":
    print("Cancelling operation.")
    exit(1)
else:
    print("Renaming...")

# Loops over files and renames them. CHANGE THIS!!
for file in files:
    os.rename(path+file, path+file+".pict") # Appends .pict to the filenames. Replace with intended effect.
