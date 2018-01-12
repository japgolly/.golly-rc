# vim:ft=sh et sw=2 ts=2:
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=30000
export HISTFILESIZE=60000
export HISTTIMEFORMAT='%F %T '

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export SHELL=bash

export PS1='\n\[\e[1;31m\]\u\[\e[0;31m\]@\[\e[1;32m\]\h\[\e[0;32m\]: \[\e[33m\]\w\[\e[0m\]\n$ '

export EDITOR=vim
export PAGER=less

alias ls='ls --color=auto --group-directories-first'
alias la='ls -la'
alias ll='ls -l'
alias lsa='ls -a'
alias view='vim -R'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias pgrep='pgrep --color=auto'

alias p='pacman -S --needed'
alias syu='pacman -Syu'
alias syua='yaourt -Syua'
alias y='yaourt -S --needed'
alias yy='yaourt -S --needed --noconfirm'

alias ql='pacman -Ql'

