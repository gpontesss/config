#Set our umask
umask 022

PATH="/usr/local/sbin:/usr/local/bin:/usr/bin/core_perl:/usr/bin:$HOME/.config/bspwm/panel:$HOME/.bin"
PATH="/var/lib/snapd/snap/bin:$PATH"
export PATH

export BROWSER=/usr/bin/firefox
export TERMINAL=/usr/bin/alacritty

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export SHELL=/bin/bash

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg

export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

export TEXMFHOME=$XDG_CONFIG_HOME/texmf

source $HOME/.bashrc
