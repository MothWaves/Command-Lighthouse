#!/usr/bin/env sh

read -p "Author Name: " author

exiv2 --Modify "set Exif.Image.Artist Ascii $author" "$1"
exiv2 --Modify "set Iptc.Application2.Byline String $author" "$1"
exiv2 --Modify "set Xmp.dc.creator XmpText $author" "$1"

exit 0
