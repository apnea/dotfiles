#!/bin/sh
xrandr --output DP-2 --rotate left --auto
xrandr --output DP-4 --right-of DP-2 --auto
picom &
nm-applet &
parcellite &
