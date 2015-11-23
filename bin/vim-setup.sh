#!/bin/bash

function install {
  url="$1"
  shift
  dir=$(echo "$url" | perl -pe 's!^.+/(.+?)(\.git)?$!\1!')
  run=
  cd ~/.vim/bundle && \
    if [ -d "$dir" ]; then
      echo "$dir: exists"
    else
      echo "$dir: installing..."
      echo
      $run git clone "$url"
      [ -n "$1" ] && cd "$dir" && $run "$@"
      echo
    fi
}

#echo ' *customization: -color
#XTerm*termName:  xterm-256color ' > ~/.Xdefaults

#curl -O http://scie.nti.st/dist/256colors2.pl && chmod 777 256colors2.pl && ./256colors2.pl; tput colors

mkdir -p ~/.vim/autoload ~/.vim/bundle \
  && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo

#install https://github.com/tpope/vim-rails.git
install https://github.com/godlygeek/csapprox.git
#install https://github.com/altercation/vim-colors-solarized.git
install https://github.com/tpope/vim-markdown.git
#install https://github.com/timcharper/textile.vim.git
install https://github.com/vim-scripts/ScrollColors.git
install https://github.com/aklt/plantuml-syntax.git
install https://github.com/flazz/vim-colorschemes.git
install https://github.com/derekwyatt/vim-scala.git
install https://github.com/pangloss/vim-javascript.git
install https://github.com/elzr/vim-json.git
#install https://github.com/terryma/vim-multiple-cursors.git
install https://github.com/kchmck/vim-coffee-script.git

# Haskell
#install https://github.com/scrooloose/syntastic.git
#install https://github.com/Shougo/vimproc.vim.git   make
#install https://github.com/eagletmt/ghcmod-vim
#install https://github.com/bitc/vim-hdevtools.git

