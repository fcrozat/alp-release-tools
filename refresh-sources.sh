#!/bin/sh

TARGET="SUSE:ALP:Source:Standard:1.0"
SOURCE="openSUSE.org:openSUSE:Factory"

echo "" >sync_log

PKG_LIST=$(osc -A https://api.suse.de ls $TARGET)
for PKG in $PKG_LIST ; do
	osc -A https://api.suse.de ls $SOURCE $PKG >/dev/null 2>/dev/null
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then
		diff=$(osc -A https://api.suse.de rdiff $TARGET $PKG $SOURCE 2>/dev/null)
		if [ -n "$diff" ]; then
	                echo "Package $PKG differs" >>sync_log ;
	                osc -A https://api.suse.de sr -m "refresh to Factory version" $SOURCE $PKG $TARGET || echo "FAILURE: submitreq for package $PKG" >>sync_log;
                else
	                 echo "Package $PKG not changed" >>sync_log ;

		fi
        else
                echo "Package $PKG does not exist in $SOURCE, ignoring" >>sync_log ;
        fi
done

