#!/bin/env bash

# Options for powermenu
lock=" Lock"
logout="﫼 Logout"
shutdown="⏻ Shutdown"
reboot=" Reboot"

# Get answer from user via rofi
selected_option=$(echo "$lock
$logout
$reboot
$shutdown" | rofi -dmenu\
                  -i\
                  -p "Power"\
                  -config "~/.config/rofi/powermenu.rasi"\
                  -width "15"\
                  -lines 5\
                  -line-margin 3\
                  -line-padding 10\
                  -scrollbar-width "0" )

# Do something based on selected option
if [ "$selected_option" == "$lock" ]
then
    xbacklight -set 0 -steps 10 && i3lock --tiling -e -i ~/.config/i3/custom/wallpaper.png
elif [ "$selected_option" == "$logout" ]
then
    i3-msg exit
elif [ "$selected_option" == "$shutdown" ]
then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    systemctl reboot
else
    echo "No match"
fi
