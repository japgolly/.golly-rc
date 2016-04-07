#!/bin/bash

source "$(dirname $0)/../lib/distro.sh"
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

# Installed packages
case "$(distro)" in
  ArchLinux)
    pacman -Q > installed_packages_and_versions
    pacman -Qe > explicit_packages_and_versions
    ;;
  Ubuntu)
    dpkg --get-selections | grep '[^a-zA-Z]install' | sed 's/[ \t].*//' | xargs dpkg -s | egrep '^(Package|Version)' | perl -0000 -pe 's/Package: (\S+)\s*[\r\n]+Version: (\S+)/\1 \2 \2/g' | perl -pe 's/ (?:\d+:)?(\S+?)[-+~]\S+$/ \1/; s/ (\S+) (\S+)$/ \2 \1/' | column -t | perl -pe 's/(\S+)(\s+\S+)$/\1    \2/' | sort \
      > installed_packages_and_versions
    ;;
esac
cat installed_packages_and_versions | awk '{print $1}' > installed_packages
cat explicit_packages_and_versions | awk '{print $1}' > explicit_packages

# User info
groups > groups

# Crontab
crontab -l > crontab

# Atom packages
rm -f atom-packages atom-themes
if [ -e ~/.atom/packages ]; then
  find ~/.atom/packages -maxdepth 2 -name package.json | xargs fgrep -l '"theme"' | perl -pe 's!/[^/\n]+$!!; s!^.+/!!' | sort > atom-themes
  find ~/.atom/packages -maxdepth 2 -name package.json | xargs fgrep -L '"theme"' | perl -pe 's!/[^/\n]+$!!; s!^.+/!!' | sort > atom-packages
fi

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
    if [ -d "$f" ]; then
      mkdir -p "$t" \
        && cp --dereference --preserve=mode,timestamps -r "$f/." "$t/."
    else
      mkdir -p "$(dirname "$t")" \
        && cp --dereference --preserve=mode,timestamps "$f" "$t" \
        && (
          # Remove troublesome and/or sensitive data
          [[ "$f" =~ smplayer.ini ]] && sed -i '
            /^\(item_.*\|volume\|pos\|size\|latest_dir\|toolbars_state\|count\|current_item\)=/d;
            /^\(mute\|shuffle\|repeat\)=\(true\|false\)/d;
            ' "$t"
          [[ "$f" =~ settings.xml ]] && perl -pi -e 's/(username|password|sign\.[a-z]+)>.+?</\1>xxxxxxxx</' "$t"
          true
        )
      fi
  fi || ((errs++))
done
[ $errs -gt 0 ] && echo "$errs errors detected. Aborting." && exit 3
echo "Done."
echo

# Git
git add -AN -- .
git st -- .
