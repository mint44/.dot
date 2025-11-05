#!/usr/bin/env bash

n=$(yabai -m query --spaces --space | jq '.windows | length')
layout=$(yabai -m query --spaces --space | jq -r '.type')

if [ $n = 1 ] || [ "$layout" = "float" ] || [ "$layout" = "stack" ]; then
    borders width=0
    
    # # Handle stack layout opacity
    # if [ "$layout" = "stack" ] && [ $n -gt 1 ]; then
    #     # Get focused window ID and app
    #     focused_window=$(yabai -m query --windows --window | jq '.id')
    #     focused_app=$(yabai -m query --windows --window | jq -r '.app')
        
    #     # If focused window is FaceTime, don't change opacity of other windows
    #     if [ "$focused_app" = "FaceTime" ]; then
    #         # Only set FaceTime to full opacity, leave others unchanged
    #         yabai -m window "$focused_window" --opacity 1.0
    #     else
    #         # Normal stack behavior: manage opacity for all windows
    #         yabai -m query --windows --space | jq -r '.[].id' | while read -r window_id; do
    #             # Check if this window is FaceTime
    #             app_name=$(yabai -m query --windows --window "$window_id" | jq -r '.app')
                
    #             if [ "$app_name" = "FaceTime" ]; then
    #                 # FaceTime always gets full opacity
    #                 yabai -m window "$window_id" --opacity 1.0
    #             elif [ "$window_id" = "$focused_window" ]; then
    #                 # Focused window gets full opacity
    #                 yabai -m window "$window_id" --opacity 0.92
    #             else
    #                 # Other windows get transparent
    #                 yabai -m window "$window_id" --opacity 0.01
    #             fi
    #         done
    #     fi
    # fi
else
    borders width=8.0
fi
