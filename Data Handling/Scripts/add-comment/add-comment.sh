#!/usr/bin/env sh

read -p "Comment: " comment

exiv2 --Modify "set Exif.Photo.UserComment Comment $comment" "$@"

exit 0
