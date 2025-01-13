#!/bin/sh
#
# picom
#picom --animations -b
picom &


# bunch of applets & systray
nm-applet --no-agent &
blueman-applet &
volctl &
/usr/bin/ideapad-perf-tray.py &


# deamon mode for thunar for auto mount services
# https://wiki.archlinux.org/title/thunar#Using_Thunar_to_browse_remote_locations
# thunar --daemon



#screen setup
autorandr --change
/home/minhb/.fehbg &
wal -i /home/minhb/Pictures/Wallpapers/wallhavens/ -n

# input gesture
libinput-gestures-setup autostart start

# pass manager
keepassxc &

#input method
ibus-daemon -rxRd

# conky
conky &
# redshift
redshift -l 42.35843:-71.05977 & # boston

#dunst
#/usr/bin/dunst

# vpn
# gpclient --start-minimized &

# set touchpad accer to .4
# xinput list & xinput list-prop
#xinput set-prop 11 307 0.4
