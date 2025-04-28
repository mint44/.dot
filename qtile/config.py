from libqtile import bar, layout, qtile, hook
from libqtile import widget as widget_base
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget import backlight
from libqtile import extension
from datetime import datetime;

from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration
from qtile_extras.popup.templates.mpris2 import DEFAULT_LAYOUT


from utils import transparentize


import subprocess
import os
import random
import re
from settings import Settings

mod = "mod4"
terminal = "kitty"


class MyQtileConfig():
    def __init__(self):
        self.setting = Settings()
        self.keys = self.get_keys()
        self.groups = self.get_groups()
        self.layouts = self.get_layouts()
        self.get_defaults()
        self.screens = self.get_screen()


    def get_keys(self):
        keys = [
            # A list of available commands that can be bound to keys can be found
            # at https://docs.qtile.org/en/latest/manual/config/lazy.html
            # media

            # requires brightnessctl pkg
            Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +10%"), desc="inc brightness"),
            Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 10%-"), desc="dec brightness"),
            Key([], "XF86AudioLowerVolume", lazy.widget["volume"].decrease_vol(), desc="dec brightness"),
            Key([], "XF86AudioRaiseVolume", lazy.widget["volume"].increase_vol(), desc="dec brightness"),
            Key([], "XF86AudioMute", lazy.widget["volume"].mute(), desc="dec brightness"),

            Key([], "Print", lazy.spawn("flameshot gui"), desc="dec brightness"),

            # warpd
            Key([mod], "z", lazy.spawn("warpd --hint"), desc="hint mode"),
            Key([mod], "x", lazy.spawn("warpd --normal"), desc="normal mode"),
            Key([mod], "c", lazy.spawn("warpd --screen"), desc="screen select mode"),

            # Switch between windows
            Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
            Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
            Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
            Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
            # Key([mod], "n", lazy.layout.next(), desc="Move window focus to other window"),
            # Grow windows. If current window is on the edge of screen and direction
            # will be to screen edge - window would shrink.
            Key([mod, "control"], "h", lazy.layout.grow_left().when(layout=["bsp", "columns"])),
            Key([mod, "control"], "l", lazy.layout.grow_right().when(layout=["bsp", "columns"])),
            Key([mod, "control"], "j", lazy.layout.grow_down().when(layout=["bsp", "columns"])),
            Key([mod, "control"], "k", lazy.layout.grow_up().when(layout=["bsp", "columns"])),

            Key([mod, "shift"], "j", lazy.layout.shuffle_down().when(layout=["bsp", "columns"])),
            Key([mod, "shift"], "k", lazy.layout.shuffle_up().when(layout=["bsp", "columns"])),
            Key([mod, "shift"], "h", lazy.layout.shuffle_left().when(layout=["bsp", "columns"])),
            Key([mod, "shift"], "l", lazy.layout.shuffle_right().when(layout=["bsp", "columns"])),

            Key([mod, "shift"], "h", lazy.layout.swap_left().when(layout=["monadtall"])),
            Key([mod, "shift"], "l", lazy.layout.swap_right().when(layout=["monadtall"])),
            Key([mod, "control"], "j", lazy.layout.shrink().when(layout=["monadtall"]), desc=""),
            Key([mod, "control"], "k", lazy.layout.grow().when(layout=["monadtall"]), desc=""),

            Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
        

            # Key([mod, "shift"], "h",
            #     lazy.layout.shuffle_left(),
            #     lazy.layout.move_left().when(layout=["treetab"]),
            #     desc="Move window to the left/move tab left in treetab"),


            # Toggle between different layouts as defined below
            Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

            Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
            Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
            Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),

            Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
            Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

            # Monitor layouts
            Key(['mod1'], "d", self._minimize_all(), desc="Toggle minimize"),  



            # Switch focus of monitors
            Key([mod], "period", lazy.next_screen(), desc='Move focus to next monitor'),
            Key([mod], "comma", lazy.prev_screen(), desc='Move focus to prev monitor'),

            # Rofi
            # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
            Key([mod], "space", lazy.spawn("rofi -show drun"), desc="Rofi"),

            # Apps
            Key([mod],  'b',     lazy.spawn("firefox")),
            Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

            # Scratch pad
            # Key([], 'F9', lazy.group['scratchpad'].dropdown_toggle('chatgpt')),
            #Key([mod,"shift"], 'v',
            Key([mod, "mod1"], "Tab",
                lazy.spawn('/home/minhb/.config/rofi/powermenu/type-2/powermenu.sh')),

            Key([mod], '0', lazy.group["scratchpad"].dropdown_toggle("chatgpt")),
            Key([mod], 'minus', lazy.group["scratchpad"].dropdown_toggle("terminal")),
            Key([mod], 'equal', lazy.group["scratchpad"].dropdown_toggle("file")),



            Key([mod], "s", toggle_sticky_windows(),    desc="Toggle state of sticky for current window",)
        ]

        self.keys = keys
        return self.keys

    def get_groups(self):
        groups = []
        group_names = self.setting.group_names
        group_labels = self.setting.group_labes

        # groups.append(Group(name=group_names[0], label=group_labels[0]))
        groups.append(Group(name=group_names[1], label=group_labels[1]))
        groups.append(Group(name=group_names[2], label=group_labels[2]))
        groups.append(Group(name=group_names[3], label=group_labels[3], matches=[
            Match(wm_class="FastX")
        ]))
        groups.append(Group(name=group_names[4], label=group_labels[4]))
        groups.append(Group(name=group_names[5], label=group_labels[5], matches=[
            Match(wm_class="obsidian"),
            Match(wm_class="Zotero"),

        ]))
        groups.append(Group(name=group_names[6], label=group_labels[6]))
        groups.append(Group(name=group_names[7], label=group_labels[7]))
        groups.append(Group(name=group_names[8], label=group_labels[8], matches=[
            Match(wm_class=re.compile(r"^(vesktop)$")),
            Match(wm_class=re.compile(r"zoom")),
            # Match(wm_class="zoom")
        ]))

        # --------------------------------------------------------
        # Scratchpads
        # --------------------------------------------------------
        for i in groups:
            self.keys.extend(
                [
                    # mod1 + letter of group = switch to group
                    Key(
                        [mod],
                        i.name,
                        lazy.group[i.name].toscreen(),
                        desc="Switch to group {}".format(i.name),
                    ),
                    # mod1 + shift + letter of group = switch to & move focused window to group
                    Key(
                        [mod, "shift"],
                        i.name,
                        lazy.window.togroup(i.name, switch_group=False),
                        desc="Switch to & move focused window to group {}".format(i.name),
                    ),
                    # Or, use below if you prefer not to switch to that group.
                    # # mod1 + shift + letter of group = move focused window to group
                    # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                    #     desc="move focused window to group {}".format(i.name)),
                ]
            )

        groups.append(ScratchPad("scratchpad", [
            DropDown("chatgpt", "chromium --new-window https://chat.openai.com", x=0.1, y=0.1, width=0.80, height=0.8, opacity=1),
            # DropDown("chatgpt", "firefox --new-instance https://chat.openai.com", x=0.1, y=0.1, width=0.80, height=0.8, opacity=1),
            # DropDown("chatgpt", "firefox https://chat.openai.com", x=0.3, y=0.1, width=0.40, height=0.4),
            DropDown("terminal", "kitty", x=0.1, y=0.1, width=0.80, height=0.8, opacity=1),
            DropDown("file", "thunar",  x=0.1, y=0.1, width=0.80, height=0.8, opacity=1),
        ]))
        return groups

    def get_layouts(self):
        from layouts.distractionfree import DistractionFree

        self.layouts = [
            # # Try more layouts by unleashing below layouts.
            # layout.Stack(num_stacks=2),
            # layout.Bsp(),
            # layout.Matrix(),
            # layout.MonadWide(),
            # layout.RatioTile(),

            # layout.Zoomy(),
            layout.MonadTall(
                margin = self.setting.window_margin,
                border_width = 3,
                border_focus = self.setting.border_focus_color,
                ratio = 0.7,
                auto_maximize = True,
            ),
            DistractionFree(
                border_width = 3,
                border_focus = self.setting.border_focus_color),
            # layout.Columns(
            #     margin = self.setting.window_margin,
            #
            #     border_width = 3,
            #     # fair = False
            #     border_focus = self.setting.border_focus_color
            # ),
            #

            
            layout.Max(
                margin = 4
            ),

            # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
            # layout.Floating(),
        ]
        return self.layouts

    def get_defaults(self):
        self.widget_defaults = dict(
            font       = self.setting.font,
            fontsize   = self.setting.font_size,
            padding    = 0,
            background = self.setting.colors[0][0],
            foreground = self.setting.colors[1][0],
        )
        self.extension_defaults = self.widget_defaults.copy()

    def get_screen(self):
        # get number of monitor:
        try:
            num_monitors = int(subprocess.run('xrandr|grep " connected"|wc -l', shell=True, stdout=subprocess.PIPE).stdout)
        except:
            num_monitors = 1

        self.screens = []
        for i in range(num_monitors):
            tray = True if (num_monitors>1 and i==0) or num_monitors==1 else False
            self.screens.append(
                Screen(
                    top=bar.Gap(self.setting.screen_edge_gap),
                    right=bar.Gap(self.setting.screen_edge_gap),
                    left=bar.Gap(self.setting.screen_edge_gap),
                    bottom=bar.Bar(
                        self._init_widgets_list(tray=tray) ,
                        size=self.setting.bar_size,
                        margin=self.setting.bar_margins,
                        # background=colors[5][0],
                        # background="#00000000"
                        opacity=self.setting.bar_opacity,
                        # border_color=self.setting.border_focus_color,
                        # border_width= 1
                    ),
                )
            )
            
        return self.screens
    

    def _init_widgets_list(self,tray=False):

        colors = self.setting.colors
        widgets_list = [
            widget.GroupBox(
                borderwidth = self.setting.bar_border_width,

                active                      = colors[1][0],
                inactive                    = transparentize(colors[1][0]),
                highlight_color             = colors[0][0],
                this_current_screen_border  = colors[1][0],
                this_screen_border          = colors [1][0],
                other_current_screen_border = colors[3][0],
                other_screen_border         = colors[3][0],

                rounded          = False,
                highlight_method = "line",
                disable_drag     = True,
                toggle           = False,
            ),
            widget.Spacer(length=self.setting.bar_spacer),
            widget.TaskList(
                padding_x = 4,
                padding_y = 1,
                theme_mode = 'preferred',
                theme_path = '/usr/share/icons/Papirus-Dark',
                border=colors[6][0],
                title_width_method = 'uniform',
                borderwidth = 2,
                max_title_width = self.setting.bar_tasklist_max_title_width,
                txt_floating='🗗 ',
                txt_maximized='🗖 ',
                txt_minimized='🗕 '
            ),

            # widget.TextBox(
            #     'Xin cho ta một khắc reo ca vui cùng em'
            # ),
            #
            widget.Mpris2(width=200,
                scroll_chars=45,
                popup_layout=DEFAULT_LAYOUT,
                # mouse_callbacks={"Button1": lambda: lazy.spawn('playerctl play-pause')},
            ),

            widget.Spacer(length=self.setting.bar_spacer),
            widget.PulseVolume(
                    # emoji=True,  # Use an icon instead of an emoji
                    # # theme_path='/path/to/your/icons',  # Path to the icon theme
                    # # get_volume_command='pamixer --get-volume',  # Command to get the volume
                    # mute_command='pamixer --toggle-mute',  # Command to toggle mute
                    # volume_up_command='pamixer --increase 5',  # Command to increase volume
                    # volume_down_command='pamixer --decrease 5',  # Command to decrease volume
                    # foreground=colors[1],
                    # background=colors[0],
                    fmt='V: {}',
                    mouse_callbacks={
                            'Button1': lazy.spawn('myxer')  # Left click to open pavucontrol
                    }


            ),
            # widget.Spacer(length=self.setting.bar_spacer),

            # widget.Image(
            #     filename='~/.config/qtile/Assets/Misc/ram.png',
            # ),

            widget.Spacer(length=self.setting.bar_spacer),

            widget.Memory(
                measure_mem='G',
                format='M:{MemUsed: .1f}{mm}',
                foreground=colors[1],
                update_interval=5,
                mouse_callbacks={
                    'Button1': lazy.spawn('kitty btop') 
                }
            ),

            # widget.BatteryIcon(
            #     theme_path=self.setting.theme_path
            # ),


            widget.Spacer(length=self.setting.bar_spacer),
            widget.Battery(
                charge_char = '\uf062',
                discharge_char = '\uf063',
                empty_char = '!',
                full_char = '\uf00c',
                format='B: {char}{percent:2.0%}',
            ),


            widget.Spacer(length=self.setting.bar_spacer),
            widget.Clock(
                format=self.setting.bar_clock_format,
            ),

            widget.Spacer(length=self.setting.bar_spacer),
            widget.CurrentLayoutIcon(
                custom_icon_paths = [self.setting.icon_path],
                scale = 0.5
            ),
            widget.Spacer(length=self.setting.bar_spacer),
            widget.TextBox(
                '󰑓',
                fontsize=20,
                # foreground=colors[0][0],
                mouse_callbacks={"Button1": lazy.spawn('{}'.format(self.setting.refresh_path))},
                # background= self.setting.border_focus_color,# '#FF5733', #eab676',#colors[2][0],
            ),

            widget.Spacer(length=self.setting.bar_spacer),
            widget.TextBox(
                '',
                fontsize=20,
                foreground=colors[0][0],
                mouse_callbacks={"Button1": lazy.spawn('{}'.format(self.setting.power_menu_path))},
                background= self.setting.border_focus_color,# '#FF5733', #eab676',#colors[2][0],
                padding=8

            ),

        ]
        if tray:
            # insert systray before memory widget
            for i,w in enumerate(widgets_list):
                if isinstance(w, widget.Volume):
                    widgets_list.insert(i-1, widget.Systray(padding = 2))
                    break

        return widgets_list

    def _change_wallpaper_and_reload(self):
        # lazy.spawn('wal -i {}'.format('~/Pictures/Wallpapers/wallhavens/'))
        lazy.spawn('wal -i {}'.format('/home/minhb/Pictures/Wallpapers/wallhavens/')) 
        lazy.reload_config()

    @lazy.function
    def _minimize_all(qtile):
        for win in qtile.current_group.windows:
            if hasattr(win, "toggle_minimize"):
                win.toggle_minimize()


############ sticky_windows
sticky_windows = []

@lazy.function
def toggle_sticky_windows(qtile, window=None):
    if window is None:
        window = qtile.current_screen.group.current_window
    if window in sticky_windows:
        sticky_windows.remove(window)
    else:
        sticky_windows.append(window)
    return window

@hook.subscribe.setgroup
def move_sticky_windows():
    for window in sticky_windows:
        window.togroup()
    return

@hook.subscribe.client_killed
def remove_sticky_windows(window):
    if window in sticky_windows:
        sticky_windows.remove(window)



############ sticky_windows


myconfig = MyQtileConfig()

keys = myconfig.keys
groups =  myconfig.groups
layouts = myconfig.layouts
widget_defaults = myconfig.widget_defaults
extension_defaults = myconfig.extension_defaults
screens = myconfig.screens


# ==============================================================================
# BUNCH OF STUFF WE DONT CARE
# Drag floating layouts.

@hook.subscribe.startup_once
def autostart():
    subprocess.call([myconfig.setting.autostart_path])


mouse = [
    Drag([mod], "Button1", lazy.window.set_position(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="zoom.real "),
        Match(wm_class="zoom"),
        Match(role="PictureInPicture")

    ],
    border_width = 3,
    border_focus = myconfig.setting.border_focus_color,

)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None
wmname = myconfig.setting.wmname
