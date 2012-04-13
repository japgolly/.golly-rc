#!/bin/bash

cd && git clone git://github.com/sstephenson/rbenv.git .rbenv
cd ~/.rbenv && (mkdir -p plugins && cd plugins && git clone git://github.com/sstephenson/ruby-build.git)
PATH="$HOME/.rbenv/bin:$PATH"; eval "$(rbenv init -)"

echo -e "\n==============================================================================="
echo "Installing JRuby 1.6.7..."
rbenv install jruby-1.6.7 \
  && rbenv rehash \
  && rbenv global jruby-1.6.7 \
  && jgem install bundler \
  && rbenv rehash

echo -e "\n==============================================================================="
echo "Installing Ruby 1.9.3..."
rbenv install 1.9.3-p125 \
  && rbenv rehash \
  && rbenv global 1.9.3-p125 \
  && gem install bundler \
  && rbenv rehash

