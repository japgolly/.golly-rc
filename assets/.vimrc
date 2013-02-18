let g:golly_rc_assets = '~/.golly-rc/assets/'
call pathogen#infect()
syntax on
filetype plugin indent on
set nobackup
set history=500
set number " Show line numbers on the left
set title           " show title in console title bar
set ttyfast         " smoother changes
set nowrap
set nohlsearch
set nocompatible
set encoding=utf8
set undodir=~/.vim/undo
set shiftwidth=4
set tabstop=4
" set cursorline

" from the vim-ruby doco
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
compiler ruby         " Enable compiler support for ruby

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
"
au BufNewFile,BufRead *.gec,Guardfile set filetype=ruby
au BufNewFile,BufRead *.gv            set filetype=dot
au filetype ruby,yaml,sh              setlocal ts=2 sw=2 expandtab textwidth=120 colorcolumn=121
au filetype markdown                  setlocal ts=2 sw=2 expandtab textwidth=80 colorcolumn=81
au filetype dot                       setlocal ts=2 sw=2 expandtab
au filetype css,scss                  setlocal ts=2 sw=2 expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
"
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
set background=dark
let g:solarized_termcolors=256
"colorscheme solarized
colorscheme vibrantink

"autocmd BufEnter * if match(@%:p,'.*/test/.*')>=0 | colorscheme autumnleaf | end
"au BufEnter * if match(expand('%:p'),'.*/test/.*')>=0 | colorscheme autumnleaf | CSApprox | end
au filetype yaml                      colorscheme dante | CSApprox
au filetype markdown                  colorscheme fruity | CSApprox
au filetype dot                       colorscheme pablo | CSApprox
au filetype diff                      colorscheme jellybeans | CSApprox
au filetype xml                       colorscheme leo | CSApprox

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight trailing spaces
hi ExtraWhitespace ctermbg=red guibg=red
au BufEnter * hi ExtraWhitespace ctermbg=red guibg=red

" Show trailing whitespace:
":match ExtraWhitespace /\s\+$/
":match ExtraWhitespace /\s\+\%#\@<!$/ "match trailing whitespace, except when typing at the end of a line
" Show trailing whitespace and spaces before a tab:
":match ExtraWhitespace /\s\+$\| \+\ze\t/

match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Macros
"
" map  - Normal, visual, select and operator pending
" map! - Insert and command-line
" nmap - Normal mode
" imap - Insert mode
" vmap - Visual and select mode
" smap - Select mode
" xmap - Visual mode
" cmap - Command-line mode
" omap - Operator pending mode

" F2 toggles line numbers on the left
nmap <silent> <F2> :set nu!<CR>
imap <silent> <F2> <C-O><F2>

" F3 toggles paste mode
nmap <F3> :set paste!<BAR>:set paste?<CR>
imap <F3> <C-O><F3>

" F4 toggles word-wrap
nmap <F4> :set wrap!<BAR>:set wrap?<CR>
imap <F4> <C-O><F4>

" F5 toggles search highlighting
nmap <F5> :set hlsearch!<BAR>:set hlsearch?<CR>
imap <F5> <C-O><F5>
vmap <F5> :

" F12 removes trailing whitespace
map  <F12> :perldo s/\s+$//<CR>
imap <F12> <C-O><F12>

" CTRL-H gets ready for a search & replace with perl regex
map <C-H> :perldo s/

" Ctrl-L[jk] Adds a blank line before/after current line
nmap <silent> <C-L>k :set paste<CR>O<Esc>:set nopaste<CR>j0w
imap <silent> <C-L>k <Esc><C-L>kA
nmap <silent> <C-L>j :set paste<CR>o<Esc>:set nopaste<CR>k0w
imap <silent> <C-L>j <Esc><C-L>jA

" Navigation macros
" alt + up/down/left/right
nmap [1;3A <C-W>k
nmap [1;3B <C-W>j
nmap [1;3C <C-W>l
nmap [1;3D <C-W>h
imap [1;3A <Esc>[1;3A
imap [1;3B <Esc>[1;3B
imap [1;3C <Esc>[1;3C
imap [1;3D <Esc>[1;3D

"-----------------------------------------------------------------
" Ruby macros
" RSpec macros
execute 'source '.g:golly_rc_assets.'vim-functions.vim'

" ,r[dD] - New describe
au filetype ruby nmap ,rD :set nopaste<CR>O<CR>describe " do<CR>end<Esc>kf"s
au filetype ruby nmap ,rd j,rD
" ,r[cC] - New context
au filetype ruby nmap ,rC :set nopaste<CR>O<CR>context "" do<CR>end<Esc>kf"a
au filetype ruby nmap ,rc j,rC
" ,r[iI] - New test (with impl)
au filetype ruby nmap <silent> ,rI :set nopaste<CR>O}<Esc>Oit(""){<Esc>hhi
au filetype ruby nmap <silent> ,ri j,rI
" ,r[pP] - New test (pending)
au filetype ruby nmap <silent> ,rP :set nopaste<CR>Oit("")<Esc>hi
au filetype ruby nmap <silent> ,rp j,rP
" ,rx - Expand pending test
au filetype ruby nmap <silent> ,rx :set nopaste<CR>A{<Esc>o}<CR><Esc>kO
" ,r[baA][ea] - before/after/around each/all blocks
au filetype ruby nmap <silent> ,rbe :set nopaste<CR>o}<Esc>Obefore(:each){<Esc>o
au filetype ruby nmap <silent> ,rba :set nopaste<CR>o}<Esc>Obefore(:all){<Esc>o
au filetype ruby nmap <silent> ,rae :set nopaste<CR>o}<Esc>Oafter(:each){<Esc>o
au filetype ruby nmap <silent> ,raa :set nopaste<CR>o}<Esc>Oafter(:all){<Esc>o
au filetype ruby nmap <silent> ,rA :set nopaste<CR>o}<Esc>Oaround(:each){\|ex\|<Esc>o
" ,rce - Class eval
au filetype ruby nmap ,rce :set nopaste<CR>oclass_eval <<-EOB<CR>EOB<Esc>O<Space><Space>
au filetype ruby nmap <silent> ,rg :call JumpImplTest()<CR>

" ,s splits line so that cursor becomes the beginning of the next line (and whitespace around cursor is removed)
au filetype ruby nmap <silent> ,s :set nohlsearch<BAR>:set nopaste<CR>i<CR><Esc>k:s/[ \t;]*$//<CR>jw
" ,S expands a line like "def asd; <cursor here> abc(123); end" into 3 lines
au filetype ruby nmap <silent> ,S ,s$b,skkw

"-----------------------------------------------------------------
" Comment macros
"
" code seperation comments
au filetype ruby,sh,yaml                  nmap <silent> ,C- :set paste<CR>O<Esc>:set nopaste<CR>O#----------------------------------------------------------------------------------------------------------------------------<Esc>0120lD0jjw
au filetype dot,javascript,cpp,c,css,scss nmap <silent> ,C- :set paste<CR>O<Esc>:set nopaste<CR>O//---------------------------------------------------------------------------------------------------------------------------<Esc>0120lD0jjw
nmap <silent> ,c- j,C-0kkw
" method doco
au filetype ruby nmap <silent> ,cD :set nopaste<CR>O#<CR><CR> @param <CR>@return <Esc>kkkA<SPACE>
au filetype ruby nmap <silent> ,Cd ,cD
au filetype ruby nmap <silent> ,cd j,cD
" @!visibility private declarations
au filetype ruby nmap <silent> ,cVP :set nopaste<CR>O# @!visibility private<Esc>0jw
au filetype ruby nmap <silent> ,Cvp ,cVP
au filetype ruby nmap <silent> ,cVp ,cVP
au filetype ruby nmap <silent> ,cvP ,cVP
au filetype ruby nmap <silent> ,cvp j,cVP
" comment line joining
au filetype ruby nmap <silent> ,cj Jd/#<CR>xd/[^ ]<CR>i <Esc>l
au filetype ruby nmap <silent> ,cJ k,cj

" CTRL-/ adds comments
au filetype ruby,sh,yaml                  map <silent>  :s/^\(\s*.\)/#\1/<CR>:set nohlsearch<CR>
au filetype vim                           map <silent>  :s/^\(\s*\)\("\s*\)\?/\1" /<CR>:set nohlsearch<CR>
au filetype plantuml                      map <silent>  :s/^\(\s*\)\('\s*\)\?/\1' /<CR>:set nohlsearch<CR>
au filetype dot,javascript,cpp,c,css,scss map <silent>  :s/^\(\s*\)\(\/\/\s*\)\?/\1\/\/ /<CR>:set nohlsearch<CR>
au filetype xml                           map <silent>  :s/^\(\s*\)/\1<!--/<CR>:s/$/-->/<CR>:set nohlsearch<CR>
imap <silent>  <Esc>w

" CTRL-\ removes comments
"au filetype ruby,sh,yaml map  <silent>  :s/^\(\s\s*#\s*\\|\s*#\s\s*\\|\(\s*\)#\(.*\)\)$/\2\3/<CR>:set nohlsearch<CR>
au filetype ruby,sh,yaml                  map <silent>  :s/^\(\s*\)#\s*/\1/<CR>:set nohlsearch<CR>
au filetype vim                           map <silent>  :s/^\(\s*\)"\s*/\1/<CR>:set nohlsearch<CR>
au filetype plantuml                      map <silent>  :s/^\(\s*\)'\s*/\1/<CR>:set nohlsearch<CR>
au filetype dot,javascript,cpp,c,css,scss map <silent>  :s/^\(\s*\)\/\/\s*/\1/<CR>:set nohlsearch<CR>
au filetype xml                           map <silent>  :s/^\(\s*\)<!--\s*/\1/<CR>:s/-->\(\s*\)$/\1/<CR>:set nohlsearch<CR>
imap <silent>  <C-O>

"-----------------------------------------------------------------
" Markdown macros
au filetype markdown nmap ,mdd a ![Done](done.png)<Esc>
au filetype markdown nmap ,mdD $,mdd
au filetype markdown nmap ,md- Yp:s/./-/g<CR>o<Esc>
au filetype markdown nmap ,md= Yp:s/./=/g<CR>o<Esc>

"-----------------------------------------------------------------
" Graphviz
au filetype dot nmap ,gd :w<CR>:silent !dot   -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>:redraw!<CR>
au filetype dot nmap ,gd :w<CR>:silent !dot   -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>:redraw!<CR>
au filetype dot nmap ,gn :w<CR>:silent !neato -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>:redraw!<CR>
au filetype dot nmap ,gf :w<CR>:silent !fdp   -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>:redraw!<CR>
au filetype dot nmap ,gs :w<CR>:silent !sfdp  -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>:redraw!<CR>
au filetype dot nmap ,gt :w<CR>:silent !twopi -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>:redraw!<CR>
au filetype dot nmap ,gc :w<CR>:silent !circo -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>:redraw!<CR>
au filetype dot nmap ,gD :w<CR>:!dot   -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>
au filetype dot nmap ,gN :w<CR>:!neato -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>
au filetype dot nmap ,gF :w<CR>:!fdp   -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>
au filetype dot nmap ,gS :w<CR>:!sfdp  -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>
au filetype dot nmap ,gT :w<CR>:!twopi -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>
au filetype dot nmap ,gC :w<CR>:!circo -Tpng -o%.png % && xdg-open %.png 2>/dev/null<CR>
au filetype dot nmap ,al A [label=""]<Esc>hi

"-----------------------------------------------------------------
" Scripts
au filetype ruby,sh nmap <silent> e :w<CR>:!./%<CR>
au filetype ruby,sh imap <silent> e <Esc>ea
