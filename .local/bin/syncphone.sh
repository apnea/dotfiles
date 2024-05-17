#!/bin/bash

# sync phone over mtp to nas on smb
# note gvfs automount or gio manual mount requires MTP USB config to be set on phone (here under 'Additional settings' -> 'Developer Options'

PHONE_DIR="/run/user/1000/gvfs/mtp:host=OnePlus_CAPE-MTP__SN%3AE1957AC4_e1957ac4/Internal shared storage/Podcasts"
PC_DIR="/run/user/1000/gvfs/smb-share:server=truenas.local,share=data/torrents/podcasts"
export TMPDIR=/tmp

#gio mount mtp:host=[device ID]
#gio mount smb://server/share

echo -e "Syncing...."
echo -e "\nFrom: $PC_DIR"
ls $PC_DIR | wc -l
echo -e "\nTo:   $PHONE_DIR"
ls "$PHONE_DIR" | wc -l
echo -e "\nTemp dir: $TMPDIR\n"

read -n 1 -s -r -p "Press any key to continue..."

echo -e "\nGo...."
# cp -rvn "$PC_DIR"/* "$PHONE_DIR"
# rsync -av --progress --iconv=utf-8-mac,utf-8 --chmod=ugo=rwX "$PC_DIR" "$PHONE_DIR"
rsync -ah --progress --no-times --no-perms --no-group --temp-dir="$TMPDIR"   "$PC_DIR"/* "$PHONE_DIR"/

echo "Done."

