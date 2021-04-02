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
export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg

export PANEL_FIFO="/tmp/panel-fifo"
export BSPWM_SOCKET="/tmp/bspwm-socket"
export PANEL_HEIGHT=25

export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# To avoid potential situation where cdm(1) crashes on every TTY, here we
# default to execute cdm(1) on tty1 only, and leave other TTYs untouched.
# if [[ "$(tty)" == '/dev/tty1' ]]; then
#     [[ -n "$CDM_SPAWN" ]] && return
#     # Avoid executing cdm(1) when X11 has already been started.
#     [[ -z "$DISPLAY$SSH_TTY$(pgrep xinit)" ]] && exec cdm
# fi

source $HOME/.bashrc
