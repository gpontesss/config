[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] \
    && . /usr/share/bash-completion/bash_completion


__gitbranch() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        printf " (%s)" "$(git branch --show-current)"
    fi
}

__venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        printf "[%s] " "$(basename "$VIRTUAL_ENV")"
    fi
}

__prompt_command() {
    local EXIT="$?"                # This needs to be first
    PS1=""

    local RCol='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local BRed='\[\e[1;31m\]'
    local BGre='\[\e[1;32m\]'
    local BBGre='\[\e[1;36m\]'
    local Yel='\[\e[0;33m\]'
    local Blu='\[\e[0;34m\]'

    PS1+="${BGre}$(__venv)${Blu}\u${Red}@${Yel}\H ${BBGre}\w${Red}$(__gitbranch)\n"

    if [ $EXIT != 0 ]; then
        PS1+="${BRed}>${RCol} "
    else
        PS1+="${BGre}>${RCol} "
    fi
}

PROMPT_COMMAND=__prompt_command    # Function to generate PS1 after CMDs

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	# if type -P dircolors >/dev/null ; then
	# 	if [[ -f ~/.dir_colors ]] ; then
	# 		eval $(dircolors -b ~/.dir_colors)
	# 	elif [[ -f /etc/DIR_COLORS ]] ; then
	# 		eval $(dircolors -b /etc/DIR_COLORS)
	# 	fi
	# fi

    # TODO: make it OS sensible
	# alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	# alias egrep='egrep --colour=auto'
	# alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# TODO: make it OS sensible
# alias cp="cp -i"                          # confirm before overwriting something
# alias df='df -h'                          # human-readable sizes
# alias free='free -m'                      # show sizes in MB
# alias more=less

# for all your nvim needs
alias \
    vim=$(which nvim) \
    nv=$(which nvim) \
    v=$(which nvim)

alias info="info --vi-keys"
alias zt="zathura"
alias spt="startspt"
alias yt="youtube-dl --add-metadata -i"
alias yta="yt -x -f bestaudio/best"

[[ -x "$(which keychain)" ]] && eval $(keychain --eval --quiet)
