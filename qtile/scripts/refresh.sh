#!/bin/sh
# -n tells `wal` to skip setting the wallpaper.
# wal -i img.jpg -n

# Using feh to tile the wallpaper now.
# We grab the wallpaper location from wal's cache so 
# that this works even when a directory is passed.
# feh --bg-tile "$(< "${HOME}/.cache/wal/wal")"  


# You can create a function for this in your shellrc (.bashrc, .zshrc).
# wal-tile() {
#     wal -n -i "$@"
#     feh --bg-tile "$(< "${HOME}/.cache/wal/wal")"
# }

# # Usage:
# wal-tile "/home/minhb/Pictures/Wallpapers/wallhavens/"
# # wal-tile ""
# # feh --bg-fill --randomize ~/Pictures/Wallpapers/wallhavens &
# # wal -i /home/minhb/Pictures/Wallpapers/wallhavens/ -n &
# qtile cmd-obj -o cmd -f reload_config 

waltile() {
    wal -n -i "$@"
    feh --bg-fill "$(< "${HOME}/.cache/wal/wal")" --bg-fill "$(< "${HOME}/.cache/wal/wal")" 
}

# Usage:
waltile "/home/minhb/Pictures/Wallpapers/wallhavens/"
# wal-tile "" # This line seems to be commented out intentionally
# feh --bg-fill --randomize ~/Pictures/Wallpapers/wallhavens & # Commented out command
# wal -i /home/minhb/Pictures/Wallpapers/wallhavens/ -n & # Commented out command
qtile cmd-obj -o cmd -f reload_config
