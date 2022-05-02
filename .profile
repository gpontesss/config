#Set our umask
umask 022

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$ANDROID_HOME/emulator"
PATH="$PATH:$ANDROID_HOME/tools/bin"
PATH="$PATH:$ANDROID_HOME/platform-tools"
PATH="$PATH:$GOPATH/bin"

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

export TEXMFHOME=$XDG_CONFIG_HOME/texmf

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export ANDROID_SDK_ROOT="/opt/android-sdk"

# needed by flutter
export CHROME_EXECUTABLE="$(which chromium)"

source $HOME/.bashrc
