#!/bin/sh

TARGET="SUSE:ALP:Source:Standard:0.1"

echo "" >sync_log

PKG_LIST=$(osc ls $TARGET | grep yast)
for PKG in $PKG_LIST ; do
	diff=$(osc pdiff $TARGET $PKG 2>/dev/null)
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then
		if [ -n "$diff" ]; then
	                echo "Package $PKG differs" >>sync_log ;
	                osc setlinkrev $TARGET $PKG || echo "FAILURE: setlinkrev for package $PKG" >>sync_log;
                else
	                 echo "Package $PKG not changed" >>sync_log ;

		fi
        else
                echo "Package $PKG is not a link to Factory, ignoring" >>sync_log ;
        fi
done
