#!/bin/bash

# Launch kitty with 4 panes
# does not work on my old kitty
kitty --title "Terminatore" \
    --session - <<EOF
layout splits
launch --var window=first fish
launch --var window=second --location=hsplit --bias=80 btop
#launch --cwd=current bash -c "kitty @ resize-window --increment -4 --axis vertical"
launch --var window=third --location=hsplit --bias 20 nvtop
focus_matching_window var:window=first
launch --location=vsplit --cwd=current ping google.com
EOF
