#!/bin/bash


export DESTINATION=$HOME/.rbenv/versions/1.9.3-p125-gcdata
mkdir $DESTINATION  ||exit 1
# Install lib yaml
cd /tmp  ||exit 1
wget http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz  ||exit 1
tar xzf yaml-0.1.4.tar.gz  ||exit 1
cd yaml-0.1.4  ||exit 1
./configure --prefix=$DESTINATION  ||exit 1
make && make install  ||exit 1
# Install a patched Ruby version
cd /tmp  ||exit 1
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p125.tar.gz  ||exit 1
tar xzf ruby-1.9.3-p125.tar.gz  ||exit 1
cd ruby-1.9.3-p125  ||exit 1
curl https://raw.github.com/wayneeseguin/rvm/master/patches/ruby/1.9.3/p125/gcdata.patch | patch -p1  ||exit 1
export CPPFLAGS=-I$DESTINATION/include  ||exit 1
export LDFLAGS=-L$DESTINATION/lib  ||exit 1
./configure --prefix=$DESTINATION --with-opt-dir=$DESTINATION/lib --enable-shared  ||exit 1
make && make install  ||exit 1
rbenv global $(basename $DESTINATION)  ||exit 1
# Install RubyGems
cd /tmp  ||exit 1
wget http://rubyforge.org/frs/download.php/75952/rubygems-1.8.21.tgz  ||exit 1
tar xzf rubygems-1.8.21.tgz  ||exit 1
cd rubygems-1.8.21  ||exit 1
ruby setup.rb  ||exit 1
rbenv rehash  ||exit 1
# Cleaning all sources and archives
rm -fr /tmp/yaml-0.1.4 /tmp/yaml-0.1.4.tar.gz /tmp/ruby-1.9.3-p125 /tmp/ruby-1.9.3-p125.tar.gz /tmp/rubygems-1.8.21.tgz /tmp/rubygems-1.8.21

gem install bundle rdoc  ||exit 1

