#!/bin/sh
DATE=$(date +%Y%m%d)
osc release SUSE:ALP --set-release=Snapshot${DATE} -r images ALP
osc release SUSE:ALP -r images 000product
