#!/usr/bin/env bash
echo 'Server Stats:'
top -bn 1 | grep 'CPU(s)' | awk -N '{print "CPU:",100-$8,"%"}'
top -bn 1 -E g | grep "GiB Mem" | awk '{print "MEM:",$8, "/",$4,"GB", "(", $8/$4*100, "% )"}'
df -h | awk '{ if ($6=="/") {print "Disk Usage of", $1, "-", $5, "("$3"/"$2")" }}'
echo $'\nTop 5 processes by CPU usage:'
ps axo pid,pcpu,comm k-pcpu | awk '{print $1,$2,$3}' | head -6 | { sed -u q; nl -w 1 -s"."; } | awk '{printf "%8s %5s %-10s\n", $1,$2,$3}'
echo $'\nTop 5 processes by memory usage:'
ps axo pid,pmem,comm k-pmem | awk '{print $1,$2,$3}' | head -6 | { sed -u q; nl -w 1 -s"." ;} | awk '{printf "%8s %5s %-10s\n", $1,$2,$3}'
