#!/bin/bash

# sync phone over mtp to nas on smb

# podcasts

PHONE_DIR="/run/user/1000/gvfs/mtp:host=OnePlus_CAPE-MTP__SN%3AE1957AC4_e1957ac4/Internal shared storage/Podcasts"
PC_DIR="/run/user/1000/gvfs/smb-share:server=truenas.local,share=data/torrents/podcasts"

echo "Syncing...."
echo "From: $PC_DIR"
echo "To:   $PHONE_DIR"
# rsync -av --progress --iconv=utf-8-mac,utf-8 --chmod=ugo=rwX "$PC_DIR" "$PHONE_DIR"
cp -rvn "$PC_DIR"/* "$PHONE_DIR"
echo "Done."

