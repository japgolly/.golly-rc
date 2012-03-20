#!/bin/bash

if [ "$1" == "-f" -o "$1" == "--force" ]; then
  force=1
  shift
fi

old_dir="$(pwd)"
cd "$(dirname $0)/../assets/" && ASSETS="$(pwd)" && cd "$old_dir"
[ ! -e "$ASSETS" ] && echo "Failed to determine asset directory." && exit 2

function link {
  printf "Symlink: %s ... " "$1"
  s="$HOME/$1"
  t="$ASSETS/$1"
  [ ! -e "$t" ] && echo "Asset not found: $t" && exit 3

  if [ ! -e "$s" ]; then
    ln -s "$t" "$s" && echo "ok" || echo "failed"
  elif [ -L "$s" ]; then
    rm "$s" && ln -s "$t" "$s" && echo "replaced link, ok" || echo "failed"
  elif [ -f "$s" -a ! -s "$s" ]; then
    rm "$s" && ln -s "$t" "$s" && echo "replaced empty file, ok" || echo "failed"
  elif [ -n "$force" ]; then
    rm -f "$s" && ln -s "$t" "$s" && echo "replaced existing file, ok" || echo "failed"
  else
    echo "already exists, aborting"
  fi
}

link .aprc
link .gitconfig
link .irbrc
link .vimrc

echo "Hardcoded appending to bashrc (TODO)"
s=~/.bashrc
t="$ASSETS"/.bashrc
echo '[ -r "'"$t"'" ] && source "'"$t"'"' >> "$s"
