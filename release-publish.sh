#!/bin/sh
DATE=$(date +%Y%m%d)
osc release SUSE:ALP:ToTest --set-release=Snapshot${DATE} -r images ALP
osc release SUSE:ALP:ToTest --set-release=Snapshot${DATE} -r images ALP-ARM
osc release SUSE:ALP:ToTest -r images 000product
osc release SUSE:ALP:ToTest --set-release=Snapshot${DATE} -r images d-installer-live
