export TERM=xterm-256color
export SHELL=/bin/bash
export BROWSER=/usr/bin/firefox
export EDITOR=/sbin/nvim
export VISUAL=/sbin/nvim

PATH="/home/gpontesss/.cargo/bin:$PATH"
PATH="$(go env GOPATH)/bin:$PATH"

export PATH

source $HOME/.bashrc
