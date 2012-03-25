#!/bin/bash

source "$(dirname $0)/../lib/general.sh"
filelist=../filelist

# Init
[ ! -d "$HOME" ] && echo "ERROR: \$HOME must point to a valid directory." && exit 4
[ -n "$1" -a -d "$1" ] && cd "$1" && shift
if [ $# -ne 0 -o -f "$(basename "$filelist")" ]; then
  echo "Usage:"
  echo "  ./$(basename $0) <dir>"
  echo "  cd <dir> && ../$(basename $0)"
  exit 1
fi
[ ! -f "$filelist" ] && echo "Filelist not found: $filelist" && exit 2

# Copy files
errs=0
# Dont do this: cat "$filelist" | while read f; do
# Subshell will be used and we will lose $errs
exec 0< "$filelist"
while read f; do
  printf "Copying: $f"
  f="$(echo "$f" | sed -e "s!^~!$HOME!")"
  t="$(echo "./$f" | sed -e "s!$HOME!/home!")"
  if [ ! -e "$f" ]; then
    echo " ... not found, skipping"
  else
    echo
    mkdir -p "$(dirname "$t")" && cp --dereference --preserve=mode,timestamps "$f" "$t"
  fi || ((errs++))
done
[ $errs -gt 0 ] && echo "$errs errors detected. Aborting." && exit 3
echo "Done."
echo

# Installed packages
case "$(distro)" in
  ArchLinux) pacman -Q > installed_packages ;;
  Ubuntu)
    dpkg --get-selections | grep '[^a-zA-Z]install' | sed 's/[ \t].*//' | xargs dpkg -s | egrep '^(Package|Version)' | perl -0000 -pe 's/Package: (\S+)\s*[\r\n]+Version: (\S+)/\1 \2 \2/g' | perl -pe 's/ (?:\d+:)?(\S+?)[-+~]\S+$/ \1/; s/ (\S+) (\S+)$/ \2 \1/' | column -t | perl -pe 's/(\S+)(\s+\S+)$/\1    \2/' | sort \
      > installed_packages
    ;;
esac

# User info
groups > groups

# Git
git add -AN -- .
git st -- .
