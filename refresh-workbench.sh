#!/bin/sh

ORIGIN="openSUSE.org:SUSE:ALP:Workbench"
TARGET="SUSE:ALP:Workbench:1.0"

ORIGIN_PKG_LIST=$(osc -A https://api.suse.de ls $ORIGIN | egrep -v '000release|000product|AGGREGATE')
TARGET_PKG_LIST=$(osc -A https://api.suse.de ls $TARGET | egrep -v '000release|000product|AGGREGATE')
for PKG in $ORIGIN_PKG_LIST ; do
	FOUND=0
	for TARGET_PKG in $TARGET_PKG_LIST ; do 
		[ "$PKG" = "$TARGET_PKG" ] && FOUND=1 && break
	done
	if [ $FOUND = 0 ]; then
		echo osc -A https://api.suse.de sr -m 'initial import' opensuse.org:openSUSE:Factory $PKG $TARGET
	fi
done
