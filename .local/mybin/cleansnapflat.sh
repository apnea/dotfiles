#!/bin/bash
# clean up flat and snap
# run as root for snap

echo "Cleaning SNAP..."
LANG=C snap list --all | awk '/disabled/{print "snap remove --purge" $1 " --revision=" $3 }' | sh -

echo "Cleaning FLATPAK..."
sudo snap set system refresh.retain=2 
flatpak uninstall --unused
