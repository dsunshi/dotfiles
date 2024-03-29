
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
# this is needed for detecting multiple displys
# this import requires python-xlib to be installed
from Xlib import display as xdisplay

import os

mod = "mod4"
terminal = guess_terminal()

# Preferred editor
editor = "emacs"

### Palette
class Colors:
    DARKEST: str  = "#000000"
    BG: str       = "#F2F4F8"
    TXT: str      = "#4C566A"
    INACTIVE: str = "#ECEFF4"
    ACTIVE: str   = "#FFFFFF"
    FOCUS: str    = "#BF616A"
    UNFOCUS: str  = "#88C0D0"
    OPACITY: float = 0.5


colors = Colors()
# Reload the config when the number of monitors has changed
# @hook.subscribe.screen_change
# def restart_on_randr(_):
#     qtile.cmd_reload_config()

def get_num_monitors():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "f", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    ###
    Key([mod], "e", lazy.spawn(editor), desc="Launch favorite editor"),
    Key([mod], "period", lazy.next_screen(), desc="Change focus to next window (monitor)"),
]

# A Unicode Character “ ” (U+2009) Thin Space is used in the label name to
# help align everything nicely
groups = [
    Group("1", label="  ", matches=[Match(wm_class=["firefox"])]),
    Group("2", label="  "),
    Group("3", label="  "),
    Group("4", label="  "),
    Group("5", label="  "),
    Group("6", label="  "),
]

for i in groups:
    keys.extend(
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
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )


layout_theme = {
    "border_width": 3,
    "margin": 15,
    "border_focus": colors.FOCUS,
    "border_normal": colors.INACTIVE,
    "border_on_single": True     # Even if there is only one window we still want the border color
}


layouts = [
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    layout.VerticalTile(**layout_theme),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Roboto-Thin",
    fontsize=12,
    padding=7,
)

back_light = widget.Backlight(
    backlight_name=os.listdir('/sys/class/backlight')[0],
    step=1,
    update_interval=None,
    format="",
    change_command=None,
#    foreground=colours[3],
)


extension_defaults = widget_defaults.copy()


#### Functions to standardize the look and feel across all of the bars

## Widget Settings

# Widget to show the current group layout
def wdgt_layout():
    """
    Current Layout via icons located in ~/.icons/
    """
    return widget.CurrentLayoutIcon(scale=0.8)

# Widget to display the groups in the bar
def wdgt_groups():
    """
    The actual the groups
    """
    return widget.GroupBox(
            highlight_method="line",
            disable_drag=True,
            font="Font Awesome 6",
            rounded=True,
            active=colors.DARKEST,
            inactive=colors.TXT,
            foreground=colors.TXT,
            background=colors.BG,
            highlight_color=[colors.ACTIVE,colors.INACTIVE],
            this_current_screen_border=colors.FOCUS,
            this_screen_border=colors.UNFOCUS,
            )

# Battery widget
def wdgt_battery(item):
    if item == 0:
        return widget.TextBox(
            text='',
            # size=20,
            font="Font Awesome 6",
            # font='JetBrains Mono Bold',
            foreground=colors.TXT,
            background=colors.BG,
        )
    elif item == 1:
        return widget.Battery(
            format='{percent:2.0%}',
            battery="BAT0",
            font="Font Awesome 6",
            charge_char="",
            fontsize=12,
            padding=10,
            foreground=colors.TXT,
            low_foreground=colors.FOCUS,
            background=colors.BG,
        )

# Clock widget
def wdgt_clock():
    return widget.Clock(
        format=" %B %d, %Y %H:%M",
        font="JetBrains Mono Nerd Font",
        foreground=colors.TXT,
        background=colors.BG,
    )

## Bar Settings
def bar_margin():
    return [10, 10, 0, 10]


screens = [
    Screen(
        wallpaper='~/wallpapers/edp.png',
        wallpaper_mode='stretch',
        top=bar.Bar(
            [
                wdgt_layout(),
                wdgt_groups(),
                # Debug monitor name
                widget.TextBox("DP0", foreground=colors.FOCUS),
                widget.Prompt(),
                #widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # widget.TextBox("sunshine config", name="default"),
                widget.Battery(font="Font Awesome 6 Free", discharge_char=""),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                back_light,
                widget.Systray(),
                widget.NvidiaSensors(),
                widget.PulseVolume(),
                wdgt_battery(0),
                wdgt_battery(1),
                wdgt_clock(),
                widget.QuickExit(),
            ],
            20,
            margin=bar_margin(),
            background=colors.BG,
            opacity=colors.OPACITY,
            # opacity=colors.OPACITY,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

if get_num_monitors() > 1:
    screens.extend(
        [
            Screen(
                wallpaper='~/wallpapers/dp112.png',
                wallpaper_mode='stretch',
                top=bar.Bar(
                    [
                        wdgt_layout(),
                        wdgt_groups(),
                        # Debug monitor name
                        widget.TextBox("DP2", foreground=colors.FOCUS),
                        widget.Prompt(),
                        widget.WindowName(),
                        # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                        # widget.StatusNotifier(),
                    ],
                    20,
                    margin=bar_margin(),
                    background=colors.BG,
                    opacity=colors.OPACITY,
                    # opacity=colors.OPACITY,
                    # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
                    # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
                ),
            ),
            Screen(
                wallpaper='~/wallpapers/dp113.png',
                wallpaper_mode='stretch',
                top=bar.Bar(
                    [
                        #widget.TaskList(),
                        wdgt_layout(),
                        wdgt_groups(),
                        # Debug monitor name
                        widget.TextBox("DP1", foreground=colors.FOCUS),
                        widget.Prompt(),
                        widget.WindowName(),
                        widget.TextBox("", foreground=colors.TXT),
                        widget.PulseVolume(
                            background=colors.BG,
                            foreground=colors.TXT,
                        ),
                        widget.TextBox(" ",
                        font="Font Awesome 6 Free",
                            foreground=colors.UNFOCUS,
                        ),
                        widget.Image(
                            filename="~/.icons/nvida.png"
                        ),
                        widget.NvidiaSensors(
                            foreground=colors.TXT,
                            background=colors.BG,
                            foreground_alert=colors.FOCUS,
                        ),
                        widget.TextBox("",
                        font="Font Awesome 6 Free",
                            foreground=colors.UNFOCUS,
                        ),
                        wdgt_clock(),
                    ],
                    20,
                    margin=bar_margin(),
                    background=colors.BG,
                    opacity=colors.OPACITY,
                    # opacity=colors.OPACITY,
                    #border_width=[2, 2, 2, 2],  # Draw top and bottom borders
                    #border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
                ),
            ),
        ]
    )

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
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
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
