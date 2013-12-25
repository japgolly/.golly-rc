#!/bin/bash
function mc { mkdir -p "$1" && cd "$1"; }

#echo ' *customization: -color
#XTerm*termName:  xterm-256color ' > ~/.Xdefaults

#curl -O http://scie.nti.st/dist/256colors2.pl && chmod 777 256colors2.pl && ./256colors2.pl; tput colors

mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim; echo
cd ~/.vim/bundle && [ ! -d vim-rails ] && (git clone git://github.com/tpope/vim-rails.git; echo)
cd ~/.vim/bundle && [ ! -d csapprox ] && (git clone git://github.com/godlygeek/csapprox.git; echo)
cd ~/.vim/bundle && [ ! -d vim-colors-solarized ] && (git clone git://github.com/altercation/vim-colors-solarized.git; echo)
cd ~/.vim/bundle && [ ! -d vim-markdown ] && (git clone git://github.com/tpope/vim-markdown.git; echo)
cd ~/.vim/bundle && [ ! -d textile.vim ] && (git clone git://github.com/timcharper/textile.vim.git; echo)
cd ~/.vim/bundle && [ ! -d ScrollColors ] && (git clone git://github.com/vim-scripts/ScrollColors.git; echo)
cd ~/.vim/bundle && [ ! -d plantuml-syntax ] && (git clone git://github.com/aklt/plantuml-syntax.git; echo)
cd ~/.vim/bundle && [ ! -d vim-colorschemes ] && (git clone git://github.com/flazz/vim-colorschemes.git; echo)
cd ~/.vim/bundle && [ ! -d vim-scala ] && (git clone git://github.com/derekwyatt/vim-scala.git; echo)
cd ~/.vim/bundle && [ ! -d vim-javascript ] && (git clone https://github.com/pangloss/vim-javascript.git; echo)
cd ~/.vim/bundle && [ ! -d vim-json ] && (git clone https://github.com/elzr/vim-json.git; echo)
# mc ~/.vim/bundle/csapprox/ && curl -o tmp http://www.vim.org/scripts/download_script.php?src_id=10336 && unzip tmp && rm tmp; echo

