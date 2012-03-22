#!/bin/bash

filelist=../filelist

# Ensure in right directory
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
  if [ ! -e "$f" ]; then
    echo " ... not found, skipping"
  else
    echo
    mkdir -p "./$(dirname "$f")" && cp --dereference --preserve=mode,timestamps "$f" "./$f"
  fi || ((errs++))
done
[ $errs -gt 0 ] && echo "$errs errors detected. Aborting." && exit 3
echo "Done."
echo

# Installed packages
case "$(uname -a)" in
  *-ARCH[^A-Za-z]*) pacman -Q > installed_packages ;;
  # TODO ubuntu
esac

# Git
git add -AN -- .
git st -- .
