# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export EDITOR=vim
export PAGER=less
export PS1='\n\[\e[32m\]\u@\h: \[\e[33m\]\w\[\e[0m\]\n$ '

alias la='ls -la'
alias ll='ls -l'
alias svnstnew='svn st --ignore-externals | fgrep ? | cut -b8-'
alias svnste='svn st --ignore-externals | grep -v ^X'
alias svn_add_rm="svnste | sort | fgrep '?' | cut -b3- | xargs --no-run-if-empty echo svn add; echo; svnste | sort | fgrep '!' | cut -b3- | xargs --no-run-if-empty echo svn rm"
alias bashrc='vim ~/.golly-rc/assets/.bashrc && echo Reloading... && . ~/.bashrc'
alias b=bundle
alias be='bundle exec'
alias rak='bundle exec rake'
alias s=xdg-open
alias vimrc='vim ~/.vimrc'
alias gemdir='pushd "`gem env | fgrep INSTALL | perl -pe "s/^.+?: //"`/gems"'
alias Vim=vim
alias view='vim -R'

function show_cp { if [ ! -r "$1" ]; then echo "Can't read: $1"; else unzip -p $1 META-INF/MANIFEST.MF | sed '/^Class-Path:/,$!d' | tr -d '\n\r' | perl -pe 's/^.+?: //; s/ //g; s/(?<=\.jar)/\n/g'; fi; }
function test_cp { show_cp "$1" | sed "s|^|$(dirname "$1")/|" | xargs -L1 ls -l; }
function mc { mkdir -p "$1" && cd "$1"; }
function git_pull_all { [ $? -eq 0 ] && set - .; find "$@" -type d -name .git | xargs -L1 -I{} bash -c 'echo "{}"; cd "{}/.." && git pull; echo'; }

#export GIT_SSL_NO_VERIFY=true
unset RUBYOPT

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# RBENV
[ -e "$HOME/.rbenv/bin" ] && export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init -)"

