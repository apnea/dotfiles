#!/bin/bash

# sync phone over mtp to nas on smb
# note gvfs automount or gio manual mount requires MTP USB config to be set on phone (here under 'Additional settings' -> 'Developer Options'

PHONE_DIR="/media/pete/NEWFOR/podcasts"
PC_DIR="/run/user/1000/gvfs/smb-share:server=truenas.local,share=data/torrents/podcasts"
export TMPDIR=/tmp

#gio mount mtp:host=[device ID]
#gio mount smb://server/share
gio mount smb://truenas.local/data/

echo -e "Syncing...."

echo -e "\nFrom: $PC_DIR"
ls $PC_DIR | wc -l; echo " folders"

echo -e "\nTo:   $PHONE_DIR"
ls "$PHONE_DIR" | wc -l; echo " folders"

echo -e "\nTemp dir: $TMPDIR\n"

read -n 1 -s -r -p "Press any key to continue..."

echo -e "\nGo...."
# cp -rvn "$PC_DIR"/* "$PHONE_DIR"
# rsync -ah --ignore-existing --progress --no-times --no-perms --no-group --temp-dir="$TMPDIR"   "$PC_DIR"/* "$PHONE_DIR"/
# find $PC_DIR -type f -mtime -15 -print0 | rsync -ah --ignore-existing --progress --no-times --no-perms --no-group --temp-dir="$TMPDIR" --include-from=- "$PHONE_DIR"/

# Find the two most recently modified subdirectories and sync them
find "$PC_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\n' | sort -n -r | head -n 1 | cut -d' ' -f2- | xargs -I{} rsync -ahv --ignore-existing --progress --no-times --no-perms --no-group --temp-dir="$TMPDIR" "{}" "$PHONE_DIR"

echo "Done."

