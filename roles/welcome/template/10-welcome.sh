#!/usr/bin/env bash
echo "
==============================
-- Welcome to {{ domain }} --
=============================="

hostName=$(uname -n)

biggestDisk=$(df -h | sort -k2 -h | tail -n1)
diskPercentage=$(echo "$biggestDisk" | awk '{ print $5 }')
totalDiskSpace=$(echo "$biggestDisk" | awk '{ print $2 }')
usedDiskSpace=$(echo "$biggestDisk" | awk '{ print $3 }')

totalMemory=$(grep MemTotal /proc/meminfo | awk '{ print $2 }')
freeMemory=$(grep MemAvailable /proc/meminfo | awk '{ print $2 }')

memoryPrecentage=$(( (totalMemory - freeMemory) * 100 / totalMemory ))
memoryUsage=$(free -h | awk '/Mem:/ { printf "%s/%s", $3, $2 }' | sed 's/i//g')

echo "
==========================================
 - Hostname............: $hostName
 - Disk Space..........: $diskPercentage ($usedDiskSpace/$totalDiskSpace)
 - Memory used.........: $memoryPrecentage% ($memoryUsage)
==========================================
"
