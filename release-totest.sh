#!/bin/sh
DATE=$(date +%Y%m%d)
osc release SUSE:ALP --set-release=Snapshot${DATE} -r images ALP
osc release SUSE:ALP --set-release=Snapshot${DATE} -r images ALP-ARM
osc release SUSE:ALP -r images 000product
osc release YaST:Head:D-Installer --no-delay --set-release=Snapshot${DATE} -r images d-installer-live
# kill the default flavor, only keep ALP one
osc wipebinaries -M default --all SUSE:ALP:ToTest d-installer-live
