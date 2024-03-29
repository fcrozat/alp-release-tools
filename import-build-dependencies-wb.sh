#!/bin/sh

ORIGIN="SUSE:ALP:Source:Standard:Core:0.1"
SOURCE="SUSE:ALP:Source:Standard:0.1"
TARGET="SUSE:ALP:Workbench"

PKG_LIST=$(osc -A https://api.suse.de ls $ORIGIN | egrep -v '000release|000product|AGGREGATE')
PKG_LIST="MozillaFirefox"
to_import=""
for PKG in $PKG_LIST ; do
	workbench_packages=$(osc buildinfo $ORIGIN $PKG standard x86_64 | grep bdep | grep Workbench | sed -e 's/.*name="\([^\"]*\).*/\1/g' | sort)
	for dependency in $workbench_packages ; do
		source_package=$(osc search -B $TARGET $dependency | sed -n '4s/^[^[:space:]]*[[:space:]]\{1,\}\([^[:space:]]\{1,\}\)[[:space:]]\{1,\}.*$/\1/p')
		import_list=$(echo $import_list $source_package| tr ' ' '\n' | sort -u| tr '\n' ' ')
	done
done

rm -f sync_log
for PKG in $(echo $import_list | sed -e 's/llvm //g') ; do
 	osc linkpac -c openSUSE:Factory $PKG $SOURCE || echo "FAILURE: linkpac for package $PKG"  >> sync_log
 	osc linkpac $SOURCE $PKG $ORIGIN || echo "FAILURE: copypac for package $PKG" >> sync_log
done
