#Set our umask
umask 022

export BROWSER=brave
export TERMINAL=alacritty
export SHELL=bash
export EDITOR=nvim
export VISUAL=nvim

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="${XDG_DATA_HOME}/cache"
export XDG_CONFIG_DIRS="/usr/etc/xdg:/etc/xdg"

PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$ANDROID_HOME/emulator"
PATH="$PATH:$ANDROID_HOME/tools/bin"
PATH="$PATH:$ANDROID_HOME/platform-tools"
PATH="$PATH:$GOPATH/bin"

export PATH

export CFG_DIR="$HOME/git/config"
export GOPATH="${XDG_DATA_HOME}/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export TEXMFHOME="$XDG_CONFIG_HOME/texmf"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ANDROID_SDK_ROOT="/opt/android-sdk"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# needed by flutter
export CHROME_EXECUTABLE="$(which chromium)"

source $HOME/.bashrc

[[ -x "$(which keychain)" ]] && eval $(keychain --eval --quiet --dir "$XDG_CACHE_HOME/keychain")
