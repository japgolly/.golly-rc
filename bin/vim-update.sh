#!/bin/bash

for d in $(find ~/.vim/bundle -type d -name .git); do
  echo $d
  cd "$d/.." && git pull
  echo
done
