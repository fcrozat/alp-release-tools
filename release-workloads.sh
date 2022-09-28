#!/bin/sh
for p in $(osc ls SUSE:ALP:Workloads | grep 'container$' | grep -v test-api ); do
  osc release SUSE:ALP:Workloads $p
done
