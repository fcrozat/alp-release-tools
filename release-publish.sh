#!/bin/sh
DATE=$(date +%Y%m%d)
osc release SUSE:ALP:ToTest --set-release=Snapshot${DATE} -r images ALP
osc release SUSE:ALP:ToTest -r images 000product
osc releaseSUSE:ALP:ToTest --no-delay --set-release=Snapshot${DATE} -r images d-installer-live
