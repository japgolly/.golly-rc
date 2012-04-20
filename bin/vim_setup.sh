#!/bin/bash
function mc { mkdir -p "$1" && cd "$1"; }

#echo ' *customization: -color
#XTerm*termName:  xterm-256color ' > ~/.Xdefaults

#curl -O http://scie.nti.st/dist/256colors2.pl && chmod 777 256colors2.pl && ./256colors2.pl; tput colors

mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim; echo
cd ~/.vim/bundle && [ ! -d vim-rails ] && (git clone git://github.com/tpope/vim-rails.git; echo)
cd ~/.vim/bundle && [ ! -d csapprox ] && (git clone git://github.com/godlygeek/csapprox.git; echo)
cd ~/.vim/bundle && [ ! -d vim-colors-solarized ] && (git clone git://github.com/altercation/vim-colors-solarized.git; echo)
cd ~/.vim/bundle && [ ! -d textile.vim ] && (git clone git://github.com/timcharper/textile.vim.git; echo)
cd ~/.vim/bundle && [ ! -d ScrollColors ] && (git clone git://github.com/vim-scripts/ScrollColors.git; echo)
# mc ~/.vim/bundle/csapprox/ && curl -o tmp http://www.vim.org/scripts/download_script.php?src_id=10336 && unzip tmp && rm tmp; echo
cd ~/.vim && curl -o tmp http://www.vim.org/scripts/download_script.php?src_id=12179 && unzip tmp && rm tmp; echo
mc ~/.vim/plugin && curl -oScrollColor.vim http://www.vim.org/scripts/download_script.php?src_id=5387; echo

