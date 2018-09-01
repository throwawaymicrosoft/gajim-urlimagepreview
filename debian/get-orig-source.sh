#!/bin/sh

set -e

test -n "$1"
PLUGIN="$1"

REPO=gajim-plugins
PACKAGE=gajim-$(echo "$PLUGIN" | sed 's/_//g')

CWD=$(pwd)
TMPDIR=$(mktemp -d)
cd "$TMPDIR"
git clone https://dev.gajim.org/gajim/"$REPO".git
( cd ./"$REPO"/"$PLUGIN"/;
  dos2unix *.py *.ui *.ini )
VERSION=$(grep ^version: ./"$REPO"/"$PLUGIN"/manifest.ini | sed 's/.*: *//')
FILENAME="$CWD"/../"$PACKAGE"_"$VERSION".orig.tar.gz
test ! -e "$FILENAME"
tar -czvf "$FILENAME" -C "$REPO"/ "$PLUGIN"/
echo You may remove "$TMPDIR" now
