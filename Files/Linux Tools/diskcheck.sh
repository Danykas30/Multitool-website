#!/bin/bash

echo "====== DISK USAGE CHECK ======"
df -h | awk '$5+0 > 80 { print "WARNING: " $6 " is " $5 " full!" }'
df -h
