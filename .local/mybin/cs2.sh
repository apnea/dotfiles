#!/bin/bash
# cd /home/$USER/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive/game/bin/linuxsteamrt64
cd /home/$USER/.var/app/com.valvesoftware.Steam/.steam/steam/steamapps/common/Counter-Strike\ Global\ Offensive/game/bin/linuxsteamrt64

## ./cs2 -dedicated +map de_dust2 -bot +bot_difficulty 2 +bot_quota 5 +bot_join_after_player 1 +notarget 0 +game_type 0 +game_mode 0
./cs2 -dedicated +map cs_office -bot +bot_difficulty 2 +bot_quota 5 +bot_join_after_player 1 +notarget 0 +game_type 0 +game_mode 0
