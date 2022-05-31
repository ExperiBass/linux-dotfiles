# Set base PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin
# Add on local paths
export PSPDEV=/usr/local/pspdev
export PATH=$PATH:$HOME/.bin:$HOME/.npm-global/bin:$HOME/.deno/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PSPDEV/bin

export ZSH="/home/ging/.oh-my-zsh"

# OMZ Config
ZSH_THEME=clean
CASE_SENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"


ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=( zsh-syntax-highlighting )

if [ -f ~/.zsh-insulter/zsh.command-not-found ]; then
    . ~/.zsh-insulter/zsh.command-not-found
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# Compilation flags
export ARCHFLAGS="-march=native"

# Config

export GPG_TTY=$(tty)

alias vis='nocorrect vis'
alias reload='source ~/.zshrc && echo -e "\\e[4;32mReloaded!\\e[0m"'
alias tldr='nocorrect tldr'
alias pnpm='nocorrect pnpm'
alias pnpx='nocorrect pnpx'
alias pipx='nocorrect pipx'
alias stack='nocorrect stack'
alias gh='nocorrect gh'
alias killall='nocorrect killall'
alias nf='neofetch'
alias yiff='nocorrect /usr/bin/yay'
alias neocities='cd ~/Builds/neocities-ruby/bin && ./neocities && cd "-"'
alias cp='cp -r'
# I M P O R T S
#
# Development
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
alias fullmms="getlmms && buildlmms"

# IBus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# Fix driver load error (use iHD instead of i965)
export LIBVA_DRIVER_NAME=iHD

# Fix audio for Zyn/ZynFusion
alias zynaddsubfx="zynaddsubfx -O pa"
alias zyn-fusion="zynaddsubfx"
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc


export PNPM_HOME="/home/ging/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
