#!/bin/bash

set -e

DRY_RUN=true
CONFIRM=true

echo "🧹 Dotfile Cleanup Script (Flatpak + Native)"
echo "Dry run: $DRY_RUN | Confirm: $CONFIRM"
echo

# Step 1: Get list of installed Flatpak apps
flatpak_apps=$(flatpak list --app --columns=application | sort)

# Step 2: Unused ~/.var/app entries
echo "🔍 Checking ~/.var/app for unused Flatpak dirs..."
var_app_unused=$(comm -23 <(ls ~/.var/app | sort) <(echo "$flatpak_apps"))
for app in $var_app_unused; do
    echo "Would delete: ~/.var/app/$app"
    $DRY_RUN || ( $CONFIRM && read -p "Delete ~/.var/app/$app? [y/N] " yn && [[ $yn == [Yy]* ]] && rm -rf "$HOME/.var/app/$app" )
done
echo

# Step 3: Unused ~/.config/com.* (Flatpak config)
echo "🔍 Checking ~/.config for unused Flatpak config dirs..."
flatpak_config_unused=$(comm -23 <(ls ~/.config | grep '^com\.' | sort) <(echo "$flatpak_apps"))
for cfg in $flatpak_config_unused; do
    echo "Would delete: ~/.config/$cfg"
    $DRY_RUN || ( $CONFIRM && read -p "Delete ~/.config/$cfg? [y/N] " yn && [[ $yn == [Yy]* ]] && rm -rf "$HOME/.config/$cfg" )
done
echo

# Step 4: Native config folders not accessed in 60+ days
echo "📁 Suggesting native ~/.config folders unused for 60+ days..."
find "$HOME/.config" -mindepth 1 -maxdepth 1 -type d -atime +60 | while read -r dir; do
    base=$(basename "$dir")
    echo "Stale native config: $dir"
    $DRY_RUN || ( $CONFIRM && read -p "Delete $dir? [y/N] " yn && [[ $yn == [Yy]* ]] && rm -rf "$dir" )
done

echo
echo "✅ Cleanup complete. Review suggested deletions carefully."

