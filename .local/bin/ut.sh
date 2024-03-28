#!/bin/bash

cd /home/$USER/UT/UnrealTournament/System
WINEPREFIX="/home/$USER/.wine"
screen wine ./UnrealTournament.exe
#echo "sleep 5"
#sleep 5
screen -m nvidia-settings
#echo "sleep 5"
#sleep 5
#echo "KILLING NVIDIA-SETTINGS..."
#ps -ef | grep nvidia-settings | awk '{if (FNR <= 1) print $2}' | xargs kill
