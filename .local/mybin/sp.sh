#!/bin/bash

PHONE_DIR="/run/user/1000/gvfs/mtp:host=OnePlus_CAPE-MTP__SN%3AE1957AC4_e1957ac4/Internal shared storage/Podcasts"
PC_DIR="/run/user/1000/gvfs/smb-share:server=truenas.local,share=data/torrents/podcasts"

ls $PC_DIR
ls "$PHONE_DIR"

#cp -rvn "$PC_DIR"/* "$PHONE_DIR"

