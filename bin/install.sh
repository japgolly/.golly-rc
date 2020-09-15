#!/bin/bash

if [ "$1" == "-f" -o "$1" == "--force" ]; then
  force=1
  shift
fi

# ----------------------------------------------------------------------------------------------------------------------

function echoF {
  echo -e "\e[1;31m$1\e[0m"
}

old_dir="$(pwd)"
cd "$(dirname "$0")/../assets/." && ASSETS="$(pwd)" && cd "$old_dir"
[ ! -e "$ASSETS" ] && echo "Failed to determine asset directory." && exit 2

function link {
  t="$2"; [ -z "$t" ] && t="$1"
  printf "Symlink: %s <- %s ... " "$1" "$t"
  s="$HOME/$1"
  t="$ASSETS/$t"
  [ ! -e "$t" ] && echoF "aborting\nAsset not found: $t" && exit 3

  if [ ! -e "$s" ]; then
    ln -s "$t" "$s" && echo "ok" || echoF "failed"
  elif [ -L "$s" ]; then
    rm "$s" && ln -s "$t" "$s" && echo "replaced link, ok" || echoF "failed"
  elif [ -f "$s" -a ! -s "$s" ]; then
    rm "$s" && ln -s "$t" "$s" && echo "replaced empty file, ok" || echoF "failed"
  elif [ -n "$force" ]; then
    rm -f "$s" && ln -s "$t" "$s" && echo "replaced existing file, ok" || echoF "failed"
  else
    echoF "already exists, aborting"
  fi
}

function source_script {
  t="$2"; [ -z "$t" ] && t="$1"
  printf "Source: %s <- %s ... " "$1" "$t"
  s="$HOME/$1"
  t="$ASSETS/$t"
  [ ! -e "$t" ] && echoF "aborting\nAsset not found: $t" && exit 3

  cmd='[ -r "'"$t"'" ] && source "'"$t"'"'
  if [ ! -e "$s" ]; then
    echo "$cmd" >> "$s"
    if [ ! -e $tmp ]; then
      echoF "failed"
    else
      echo "created, ok"
    fi
  else
    tmp=/tmp/golly-rc.$$.tmp
    (cat "$s" | (fgrep -v "$cmd" || true) && echo "$cmd") > $tmp
    if [ ! -e $tmp ]; then
      echoF "failed"
    else
      cat $tmp > "$s" && echo "updated, ok" || echoF "failed"
    fi
  fi
}

# ----------------------------------------------------------------------------------------------------------------------

link .aprc
link .gitconfig
link .irbrc
link .vimrc
link .tmux.conf
link .XCompose XCompose

mkdir -p ~/.atom
link .atom/keymap.cson
link .atom/snippets.cson
link .atom/styles.less

mkdir -p ~/.config/'Code - OSS'/User
link '.config/Code - OSS/User/keybindings.json'
link '.config/Code - OSS/User/settings.json'
link '.config/Code - OSS/User/snippets'

mkdir -p ~/.config/mpv
link .config/mpv/input.conf

source_script .bashrc shell.rc-bash
source_script .zshrc shell.rc-zsh

mkdir -p ~/.sbt/1.0/plugins
link .sbt/1.0/global.sbt
link .sbt/1.0/plugins/plugins.sbt
