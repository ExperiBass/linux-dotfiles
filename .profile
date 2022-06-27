# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export PATH=$PATH:$HOME/.bin:$HOME/.npm-global/bin:$HOME/.deno/bin:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin

# set wallpaper
feh --bg-fill ~/.config/i3/custom/wallpaper.png

# fix driver issue
export LIBVA_DRIVER_NAME=iHD

# fix gnome-keyring
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
export GPG_TTY=$(tty)
