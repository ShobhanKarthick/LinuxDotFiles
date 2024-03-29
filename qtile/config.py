# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile import qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "alacritty"

keys = [

    ########################### Window Focus ###############################

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Tab", lazy.layout.next(), desc="Move window focus to other window"),

    ########################## Window Movement #############################

    Key([mod, "shift"], "h", 
        lazy.layout.shuffle_left(),
        lazy.layout.swap_left(),
        desc="Move window to the left"),

    Key([mod, "shift"], "l", 
        lazy.layout.shuffle_right(),
        lazy.layout.swap_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    ########################### Window Resize ################################

    Key([mod, "control"], "h", 
        lazy.layout.grow_left(),
        lazy.layout.shrink_main(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        desc="Grow window to the left"),

    Key([mod, "control"], "l", 
        lazy.layout.grow_right(),
        lazy.layout.grow_main(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        desc="Grow window to the right"),

    Key([mod, "control"], "j", 
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc="Grow window down"),

    Key([mod, "control"], "k", 
        lazy.layout.grow_up(), 
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc="Grow window up"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "space", lazy.prev_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
    Key([mod], "p", lazy.spawn("dmenu_run"),
        desc="Spawn a command using a prompt widget"),

 ###################### Application Shortcuts ############################

    Key([mod, "shift"], "s", lazy.spawn("flameshot gui"), 
        desc="Launch flameshot screenshot tool"),
    Key([mod], "f", lazy.spawn("firefox-nightly"),
        desc="Launch Firefox Dev"),

]

 

 ############################## Groups ###################################

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

 ############################## Layouts ###################################

layouts = [

    layout.MonadTall(
        change_size=10, 
        border_width=2,
        margin=8,
    ),    

    layout.MonadWide(
        border_width=2,
        margin=8,
    ),

    layout.Columns(
        border_focus_stack=['#00ff00', '#00ff00'],
        border_width=2,
        margin=8,
    ),
        
    layout.Max(
        border_width=2,
    ),

    layout.Floating(
        border_width=2,
    ),

    layout.Stack(
        num_stacks=2,
        margin=8,
    ),

    layout.Bsp(
        border_width=2,
        margin=8,
    ),

    layout.Matrix(
        border_width=2,
        margin=8,
    ),

    layout.RatioTile(
        border_width=2,
        margin=8,
    ),

    layout.Tile(
        border_width=2,
        margin=8,
    ),
    
    layout.VerticalTile(
        border_width=2,
        margin=8,
    ),

    layout.Zoomy(
        border_width=2,
        margin=8,
    ),
]
 ############################ COlors ###############################


colors = [["#282c34", "#282c34"],
          ["#3d3f4b", "#434758"], # background for current screen tab
          ["#ffffff", "#ffffff"], # font color for group names
          ["#ff5555", "#ff5555"], # border line color for current tab
          ["#320c47", "#320c47"], # border line color for 'other tabs' and color for 'odd widgets'
          ["#4f76c7", "#4f76c7"], # color for the 'even widgets'
          ["#0a7268", "#0a7268"], # window name
          ["#ecbbfb", "#ecbbfb"],
          ["#222222", "#222222"],
         ]

 ############################ Widget List ################################

def widgetList():
    widgets = [
        widget.CurrentLayout(),
        widget.GroupBox(
            padding_y=10,
        ),
        widget.Prompt(),
        widget.WindowName(),
        widget.Chord(
            chords_colors={
                'launch': ("#ff0000", "#ffffff"),
            },
            name_transform=lambda name: name.upper(),
        ),
        widget.TextBox(
            "\U0001F4D3 Config",
            name="default",
            mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e vim ' + os.path.expanduser('~/.config/qtile/config.py')),},
            foreground = colors[2],
            background = colors[6],
        ),
        widget.Sep(
            linewidth = 0,
            padding = 0,
        ),
        widget.Clock(
            format='\U0001F4C5  %a, %d %b %Y %I:%M %p',
            foreground = colors[2],
            background = colors[3],
        ),
        widget.Sep(
            linewidth = 0,
            padding = 0,
        ),
        widget.Net(
            interface="wlp3s0",
            format='\U0001F310 {down}  ↓↑ {up}',
            padding = 5,
            foreground = colors[2], 
            background = colors[4],

        ),
        widget.Sep(
            linewidth = 0,
            padding = 0,
        ),
        widget.Battery(
            format="\U0001F50B  {char} {percent:2.0%}  |  {hour:d}:{min:02d}",
            update_interval=30,
            foreground = colors[2],
            background = colors[5],
        ),
        widget.Sep(
            linewidth = 0,
            padding = 0,
        ),
        widget.Systray(
            foreground = colors[2],
            background = colors[0],
        ),
        widget.QuickExit(
            default_text="\u23FB",
            fontsize=15,
            foreground = colors[2],
            background = colors[0],
        ),
    ]
    return widgets

 ########################### Widget Config ###############################

widget_defaults = dict(
    font='Noto Sans',
    fontsize=13,
    padding=8,
    background = colors[8]
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(widgetList(), 24,),
    ),
]

 ###################### Floating Window Config #############################

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

@hook.subscribe.startup_once
def start_once():
        home = os.path.expanduser('~')
        subprocess.call([home + '/.config/qtile/autostart.sh'])


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
