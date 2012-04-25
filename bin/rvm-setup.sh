#!/bin/bash

cd

if [ ! -e .rvm ]; then
  echo -e "==============================================================================="
  echo "Installing RVM..."
  curl -L get.rvm.io | bash -s stable
  sed -ie '/\/\.rvm\//d' .bashrc .bash_profile .zshrc .zlogin
  sed -ie '${/^$/d}' .bashrc .bash_profile .zshrc .zlogin
  [ ! -s .zlogin ] && rm .zlogin
  source "$HOME/.rvm/scripts/rvm"
  export PATH="$HOME/.rvm/bin:$PATH"
fi

echo -e "\n==============================================================================="
echo "Installing JRuby 1.6.7..."
rvm install jruby-1.6.7 \
  && rvm use jruby-1.6.7 \
  && jgem install bundler

echo -e "\n==============================================================================="
echo "Installing Ruby 1.9.3..."
rvm install 1.9.3 \
  && rvm use --default 1.9.3 \
  && gem install bundler

