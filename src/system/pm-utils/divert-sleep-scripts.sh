#!/usr/bin/env bash

DIVDIR=/opt/diverted-pkg-files

mkdir -p "$DIVDIR"  

# loop over each file under sleep.d
for f in /usr/lib/pm-utils/sleep.d/*; do
	bn=$(basename "$f")
	dpkg-divert \
		--local \
		--add \
		--rename \
		--divert "$DIVDIR/$bn" \
		"$f" 
done
