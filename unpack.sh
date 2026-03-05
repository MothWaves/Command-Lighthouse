#!/usr/bin/env bash

# Unpacks (the important) tools from the Lighthouse to /usr/local/bin.

echo "Unpacking scripts to /usr/local/bin"
echo "Unpacking ./RNG/Scripts/wheel/wheel.rb..."
sudo cp ./RNG/Scripts/wheel/wheel.rb /usr/local/bin/wheel
echo "Unpacking ./Common/Scripts/compare-strings/comparestrings.sh..."
sudo cp ./Common/Scripts/compare-strings/comparestrings.sh /usr/local/bin/comparestrings
echo "Unpacking ./Common/Scripts/oldify/oldify.sh..."
sudo cp ./Common/Scripts/oldify/oldify.sh /usr/local/bin/oldify
echo "Done unpacking to /usr/local/bin"
