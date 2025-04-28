# wttr temp in boston
TEMP=$(curl -s wttr.in/boston?format="%t")
sketchybar --set "temp" label="Boston: $TEMP"