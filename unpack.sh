#!/usr/bin/env bash

# Unpacks (the important) tools from the Lighthouse to /usr/local/bin.

copy="sudo cp -i"

echo "Unpacking scripts to /usr/local/bin"
echo "Unpacking ./RNG/Scripts/wheel/wheel.rb..."
$copy ./RNG/Scripts/wheel/wheel.rb /usr/local/bin/wheel
echo "Unpacking ./Common/Scripts/compare-strings/comparestrings.sh..."
$copy ./Common/Scripts/compare-strings/comparestrings.sh /usr/local/bin/comparestrings
echo "Unpacking ./Common/Scripts/oldify/oldify.sh..."
$copy ./Common/Scripts/oldify/oldify.sh /usr/local/bin/oldify
echo "Unpacking ./Data Handling/Scripts/add-author/add-author.sh..."
$copy "./Data Handling/Scripts/add-author/add-author.sh" "/usr/local/bin/add-author"
echo "Unpacking ./Data Handling/Scripts/add-author/add-comment.sh..."
$copy "./Data Handling/Scripts/add-comment/add-comment.sh" "/usr/local/bin/add-comment"
echo "Done unpacking to /usr/local/bin"
