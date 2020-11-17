TERM=/usr/bin/alacritty
SHELL=/bin/bash
BROWSER=/usr/bin/firefox

setxkbmap -layout abnt

PATH="/home/gpontesss/.cargo/bin:$PATH"
PATH="$(go env GOPATH)/bin:$PATH"

alias vim=nvim
alias nv=nvim

eval $(ssh-agent -a ~/.ssh/socket 2> /dev/null)
export $SSH_AUTH_SOCK
export $SSH_AGENT_PID

