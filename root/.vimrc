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

" from the vim-ruby doco
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Tell vim to remember certain things when we exit
"  "       Maximum number of lines saved for each register
"  %       When included, save and restore the buffer lis
"  '       Maximum number of previously edited files for which the marks are remembered
"  /       Maximum number of items in the search pattern history to be saved
"  :       Maximum number of items in the command-line history
"  <       Maximum number of lines saved for each register.
"  @       Maximum number of items in the input-line history
"  h       Disable the effect of 'hlsearch' when loading the viminfo
"  n       Name of the viminfo file.  The name must immediately follow the 'n'.
"  r       Removable media.  The argument is a string
"  s       Maximum size of an item in Kbyte
let &viminfo="%,'10,:20,/10,n~/.viminfo"

" Make Vim restore cursor position in files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
"
au BufNewFile,BufRead *.gec,Guardfile set filetype=ruby
au BufNewFile,BufRead *.gv            set filetype=dot
au filetype ruby,yaml,sh,haskell      setlocal ts=2 sw=2 expandtab textwidth=120 colorcolumn=121
au filetype markdown                  setlocal ts=2 sw=2 expandtab textwidth=120 colorcolumn=121
au filetype dot                       setlocal ts=2 sw=2 expandtab
au filetype css,scss                  setlocal ts=2 sw=2 expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
"
colo desert

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight trailing spaces
hi ExtraWhitespace ctermbg=red guibg=red
au BufEnter * hi ExtraWhitespace ctermbg=red guibg=red

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


