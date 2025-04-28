# /bin/sh
# determine current layout of space and set label and icon accordingly
LAYOUT=$(yabai -m query --spaces --space | jq -r '.type')

# toggle between bsp and float and stack
case $LAYOUT in
  'bsp')
    yabai -m space --layout float
    ;;
  'float')
    yabai -m space --layout stack
    ;;
  'stack')
    yabai -m space --layout bsp
    ;;
esac
# send an event to sketchybar to update the layout icon event_custom_layout_changed
sketchybar --trigger event_custom_layout_changed
