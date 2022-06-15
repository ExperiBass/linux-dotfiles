# Set base PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin
# Add on local paths
export PSPDEV=/usr/local/pspdev
export PATH=$PATH:$HOME/.bin:$HOME/.npm-global/bin:$HOME/.deno/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PSPDEV/bin:$HOME/go/bin
export ZSH="/home/ging/.oh-my-zsh"
export PNPM_HOME="/home/ging/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# OMZ Config
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

source $ZSH/oh-my-zsh.sh

# User configuration

# config
## envsetup
export MAKEFLAGS=-j6
export GPG_TTY=$(tty)
export VISUAL="vim"
export EDITOR="$VISUAL"
export XDG_CONFIG_HOME="$HOME/.config"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
## aliases
alias fl='env WINEPREFIX="$HOME/.local/share/wineprefixes/fl-stuwudio" wine64 $HOME/.local/share/wineprefixes/fl-stuwudio/Program\ Files/Image-Line/Fl\ Studio\ 20/FL64\ \(scaled\).exe'
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
encodeqr() { qrencode $1 -o - | feh - }

## imports
### Development
source ~/.config/zsh/ssh.zsh.config
source ~/.config/zsh/distcc.zsh.config
source ~/.config/zsh/ftp.zsh.config

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

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /home/ging/Downloads/void/node_modules/.pnpm/tabtab@2.2.2/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/ging/Downloads/void/node_modules/.pnpm/tabtab@2.2.2/node_modules/tabtab/.completions/electron-forge.zsh
alias lansetup='sudo sysctl net.ipv4.ip_forward=1 && sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE && sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT && sudo iptables -A FORWARD -i wlan1 -o wlan0 -j ACCEPT'
alias lanup='nmcli device connect wlan1'
alias landown='nmcli device disconnect wlan1'
