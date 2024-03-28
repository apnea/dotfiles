#!/bin/bash


WINEPREFIX="/home/$USER/.wine"

cat /home/$USER/.wine/drive_c/users/$USER/My\ Documents/My\ Games/Beyond\ the\ Sword/CivilizationIV.ini | grep "Mod ="

cd /home/$USER/.wine/drive_c/Program\ Files\ \(x86\)/Firaxis\ Games/Sid\ Meier\'s\ Civilization\ 4/Beyond\ the\ Sword/
pwd
wine ./Civ4BeyondSword.exe
