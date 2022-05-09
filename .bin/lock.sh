#!/usr/bin/env bash

##############################################
##       Author: Gingka/Ginger Pepper       ##
##     https://experibassmusic.eth.link     ##
##############################################

# get needed devices
KEYBOARD=apple::kbd_backlight

# define functions
backlight_get() {
	brightnessctl --device=${KEYBOARD} g
}

# get current values
backlight=$(xbacklight -get)
keeb_backlight=$(backlight_get)

xbacklight -set 0 -steps 10 && ~/.bin/keyboard-backlight 0 \
    && i3lock --tiling -enui ~/.config/i3/custom/wallpaper.png \
    && xbacklight -set "$backlight" -steps 10 && ~/.bin/keyboard-backlight "$keeb_backlight"