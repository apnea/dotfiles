#!/bin/bash
free -h
echo "echo 3 > /proc/sys/vm/drop_caches"
echo 3 > /proc/sys/vm/drop_caches
echo "swapoff -av && swapon -av"
swapoff -av && swapon -av
echo "done...\n"
free -h
