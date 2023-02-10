#!/bin/sh

ORIGIN="SUSE:ALP"
TARGET="SUSE:ALP:Workbench"

PKG_LIST=$(osc ls $ORIGIN | egrep -v '000release|000product|AGGREGATE')
for PKG in $PKG_LIST ; do
	link=$(osc cat -u $ORIGIN $PKG _link 2> /dev/null)
	RETVAL=$?
	if [ $RETVAL -eq 0 ]; then
		if [ -n "$link" ]; then
			echo $link | grep -q 'project="openSUSE:Factory"'
			RETVAL=$?
			if [ $RETVAL -eq 0 ]; then
				echo $link | grep -q 'apply name="project.diff"'
				RETVAL=$?
				if [ $RETVAL -eq 0 ]; then
	        			osc copypac $ORIGIN $PKG $TARGET  || echo "FAILURE: copypac for package $PKG" >>sync_log;
				else
	        			osc copypac openSUSE:Factory $PKG $TARGET  || echo "FAILURE: copypac for package $PKG" >>sync_log;
				fi
			fi
		else
	        	osc copypac openSUSE:Factory $PKG $TARGET  || echo "FAILURE: copypac for package $PKG" >>sync_log;
		fi
	else
		osc copypac $ORIGIN $PKG $TARGET  >>sync_log;
	fi
	LINKED=$(osc showlinked $ORIGIN $PKG | grep "^SUSE:ALP " | sed -e "s/$ORIGIN //g")
	for LINK in $LINKED ; do 
		osc linkpac $TARGET $PKG $TARGET $LINK  >>sync_log;
	done
done
