alias vim=nvim
alias nv=nvim
alias v=nvim

TERM=/usr/bin/alacritty
SHELL=/bin/bash
BROWSER=/usr/bin/firefox
EDITOR=vim
VISUAL=vim

# TODO: Not really sure if it should be in here
setxkbmap -layout abnt

PATH="/home/gpontesss/.cargo/bin:$PATH"
PATH="$(go env GOPATH)/bin:$PATH"

export PATH
