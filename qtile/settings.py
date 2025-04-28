from dataclasses import dataclass
from typing import List
from colors import *
import os

@dataclass
class Settings:
    wmname: str = "LG3D"

    margin: float = 0.0
    corner_radius: int = 5
    screen_edge_gap: int = 10

    bar_border_width = 3 # groupbox
    bar_margins = [3, 15, 3, 15]
    bar_size    = 28
    bar_spacer  = 8
    bar_opacity = 1.0

    bar_tasklist_max_title_width = 200
    bar_clock_format = '%a, %b %d  %I:%M %p'


    window_margin: int = max(bar_margins) - screen_edge_gap

    font: str = "SFMono Nerd Font, Italic"
    font_size: int= 14


    group_names = [0, "1", "2", "3", "4", "5", "6", "7", "8"]
    group_labes = [0, "1 : ", "2 : ", "3 : ", "4 : ","5 : " , "6 : ", "7 : ", "8 : \uf1ff"  ]

    power_menu_path = os.path.expanduser('~/.config/rofi/powermenu/type-2/powermenu.sh')
    icon_path       = os.path.expanduser('~/.config/qtile/icons')
    theme_path      = os.path.expanduser('~/.config/qtile/Assets/Battery/')
    autostart_path  = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    wallpaper_path  = os.path.expanduser('~/Pictures/Wallpapers/wallhavens/')
    refresh_path    = os.path.expanduser('~/.config/qtile/scripts/refresh.sh')

    # colors = MonokaiPro
    # colors = Nord
    colors = WalColor

    border_focus_color: str = colors[6][0] #'#00beed' #'#8f09be'


import gi
import os
import json
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

class SettingsApp(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Qtile Settings")

        self.set_border_width(10)
        self.set_default_size(400, 300)

        # Create a grid to arrange widgets
        grid = Gtk.Grid()
        self.add(grid)

        # Widgets for 'margin'
        margin_label = Gtk.Label(label="Margin")
        grid.attach(margin_label, 0, 0, 1, 1)
        self.margin_entry = Gtk.Entry()
        self.margin_entry.set_text("0.0")  # Default value, replace with actual if necessary
        grid.attach(self.margin_entry, 1, 0, 1, 1)

        # Widgets for 'corner_radius'
        corner_radius_label = Gtk.Label(label="Corner Radius")
        grid.attach(corner_radius_label, 0, 1, 1, 1)
        self.corner_radius_entry = Gtk.Entry()
        self.corner_radius_entry.set_text("10")  # Default value, replace with actual if necessary
        grid.attach(self.corner_radius_entry, 1, 1, 1, 1)

        # Widgets for 'screen_edge_gap'
        screen_edge_gap_label = Gtk.Label(label="Screen Edge Gap")
        grid.attach(screen_edge_gap_label, 0, 2, 1, 1)
        self.screen_edge_gap_entry = Gtk.Entry()
        self.screen_edge_gap_entry.set_text("10")  # Default value, replace with actual if necessary
        grid.attach(self.screen_edge_gap_entry, 1, 2, 1, 1)

        # Save button
        save_button = Gtk.Button(label="Save")
        save_button.connect("clicked", self.on_save_clicked)
        grid.attach(save_button, 0, 2, 2, 1)

        # Close button
        close_button = Gtk.Button(label="Close")
        close_button.connect("clicked", self.on_close_clicked)
        grid.attach(close_button, 0, 3, 2, 1)

    def on_close_clicked(self, widget):
        self.destroy()
    def on_save_clicked(self, widget):
        settings = {
            "wmname": self.wmname_entry.get_text(),
            "margin": float(self.margin_entry.get_text()),
            # Retrieve and store other settings here...
        }

        self.write_settings(settings)

    def write_settings(self, settings):
        settings_path = Path(os.path.expanduser('~/.config/qtile/settings.py'))
        with settings_path.open("r") as file:
            lines = file.readlines()

        with settings_path.open("w") as file:
            for line in lines:
                if line.startswith("    wmname: str ="):
                    file.write(f'    wmname: str = "{settings["wmname"]}"\n')
                elif line.startswith("    margin: float ="):
                    file.write(f'    margin: float = {settings["margin"]}\n')
                else:
                    file.write(line)


if __name__ == "__main__":
    win = SettingsApp()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
