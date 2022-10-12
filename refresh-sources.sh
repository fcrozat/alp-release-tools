#!/bin/sh

TARGET="SUSE:ALP"

echo "" >sync_log

PKG_LIST=$(osc ls $TARGET | grep -v -E '^000|kernel-default|kernel-obs-build')
echo $PKG_LIST
for PKG in $PKG_LIST ; do
        if osc rdiff openSUSE:Factory $PKG $TARGET |grep '^[+-]' >/dev/null ; then
                echo "Package $PKG differs" >>sync_log ;
                osc setlinkrev $TARGET $PKG || echo "FAILURE: setlinkrev for package $PKG" >>sync_log;
        else
                echo "Package $PKG not changed" >>sync_log ;
        fi
done
