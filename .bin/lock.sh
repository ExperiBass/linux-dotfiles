#!/usr/bin/env bash

##############################################
##       Author: Gingka/Ginger Pepper       ##
##     https://experibassmusic.eth.link     ##
##############################################

# get needed devices
KEYBOARD=:white:kbd_backlight

# define functions
backlight_get() {
	brightnessctl --device=${KEYBOARD} g
}

# get current values
backlight=$(xbacklight -get)
keeb_backlight=$(backlight_get)
background=~/.config/i3/custom/lock.png
#magick ~/.config/i3/custom/wallpaper "$background"
xbacklight -set 0 -steps 10 && ~/.bin/keyboard-backlight 0 &&
    dunstctl set-paused "true" &&
    i3lock --tiling -eni "$background" &&
    dunstctl set-paused "false" &&
    xbacklight -set "$backlight" -steps 10 && ~/.bin/keyboard-backlight "$keeb_backlight"
