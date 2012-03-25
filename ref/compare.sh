#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: <file relative to this script>"
  exit 1
fi

# Ensure $HOME correct
[ -z "$HOME" ] && echo "\$HOME not set." && exit 3
[ ! -d "$HOME" ] && echo "\$HOME is not a directory: $HOME" && exit 3

# Set source and target filenames
s="$1"
[ ! -f "$s" ] && echo "Not a file: $s" && exit 2
t="$(echo "$s" | perl -pe "s!^.+?/!/!; s!^/home/!$HOME/!")"
td="$(dirname "$t")"
echo "Local: $t"
echo "Ref:   $s"
[ ! -d "$td" ] && echo "Directory doesn't exist: $td" && exit 10

# Check if sudo needed
sudo=
([ -f "$t" -a ! -w "$t" ] || [ ! -e "$t" -a ! -w "$td" ]) && sudo=sudo

# Edit!
echo "Starting vim..."
$sudo vim -o "$t" "$s"
