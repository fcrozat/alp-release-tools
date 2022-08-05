#!/bin/sh

ORIGIN="devel:LEO"
TARGET="SUSE:ALP"

PKG_LIST=$(osc ls $ORIGIN | egrep -v '000release|000product')
for PKG in $PKG_LIST ; do
        osc linkpac -c openSUSE:Factory $PKG $TARGET  || echo "FAILURE: linkpac for package $PKG" >>sync_log;
done
