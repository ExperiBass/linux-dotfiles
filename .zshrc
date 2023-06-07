export PSPDEV=/usr/local/pspdev
export PNPM_HOME="$HOME/.local/share/pnpm"
# Set base PATH
export BASEPATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin

# Add on local paths
export NPMPATH="$PNPM_HOME:$HOME/.npm-global/bin"
export MISCPATH="$HOME/.deno/bin:$HOME/.cargo/bin:$PSPDEV/bin:$HOME/go/bin"
export LOCALPATH="$HOME/.bin:$HOME/.local/bin"
export PATH="$LOCALPATH:$MISCPATH:$NPMPATH:$BASEPATH"

# XDG shit
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# OMZ Config
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=clean
CASE_SENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=( zsh-syntax-highlighting zsh-autosuggestions colored-man-pages)

if [ -f ~/.zsh-insulter/zsh.command-not-found ]; then
    . ~/.zsh-insulter/zsh.command-not-found
fi

source "$ZSH"/oh-my-zsh.sh

# User configuration

# config
## envsetup
export MAKEFLAGS=-j6
export GPG_TTY=$(tty)
export VISUAL="vim"
export EDITOR="$VISUAL"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CONAN_USER_HOME="$XDG_CONFIG_HOME"
export DISTCC_DIR="$XDG_CONFIG_HOME"/distcc
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go 
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
#export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
### ruby bundle
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export STACK_XDG=1
export WINEPREFIX="$XDG_DATA_HOME"/wine

## aliases
alias fl='env WINEPREFIX=/home/ging/.local/share/wineprefixes/fl-stuwudio wine64 $HOME/Desktop/FL\ Studio\ 20.lnk'
alias vis='nocorrect vis'
alias reload='source ~/.zshrc && echo -e "\\e[4;32mReloaded!\\e[0m"'
alias tldr='nocorrect tldr'
alias pnpm='nocorrect pnpm'
alias pnpx='nocorrect pnpx'
alias pipx='nocorrect pipx'
alias stack='nocorrect stack'
alias gh='nocorrect gh'
alias nnn='nnn -edUHior'
alias killall='nocorrect killall'
alias nf='neofetch'
alias cp='cp -ruv'
alias ferium='nocorrect ferium'
alias yiff='nocorrect yay'

## functions
encodeqr() { qrencode "$1" -o - | feh -; }

## imports
### Development
source "$HOME/.config/zsh/ssh.zsh.config"
source "$HOME/.config/zsh/distcc.zsh.config"
source "$HOME/.config/zsh/ftp.zsh.config"

# Furry MUCKs
alias furrymuck='telnet furrymuck.com 8888'
alias furtoonia='telnet ft.furtoonia.net 9999'

# LMMS
alias getlmms="git clone --recurse-submodules -b master https://github.com/lmms/lmms && cd ./lmms && mkdir build"
alias buildlmms='cmake .. -DCMAKE_INSTALL_PREFIX=../target/  -Wno-dev -DWANT_CARLA=ON -DWANT_VST=ON -DCMAKE_PREFIX_PATH=/usr/lib/wine && make -j14'
alias updatelmms="git remote update && git pull && git submodule update --init --recursive"
alias uablmms="updatelmms && cd ./build && buildlmms"
alias fullmms="getlmms && cd ./build && buildlmms"

# Fix driver load error (use iHD instead of i965)
export LIBVA_DRIVER_NAME=iHD

# install script mods
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

alias lansetup='sudo sysctl net.ipv4.ip_forward=1 && sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE && sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT && sudo iptables -A FORWARD -i wlan1 -o wlan0 -j ACCEPT'
alias lanup='nmcli device connect wlan1'
alias landown='nmcli device disconnect wlan1'
