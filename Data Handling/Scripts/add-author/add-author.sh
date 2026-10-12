#!/usr/bin/env sh

read -p "Author Name: " author

exiv2 --Modify "set Exif.Image.Artist Ascii $author" "$@"
exiv2 --Modify "set Iptc.Application2.Byline String $author" "$@"
exiv2 --Modify "set Xmp.dc.creator XmpText $author" "$@"

exit 0
