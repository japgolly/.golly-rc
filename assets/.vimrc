call pathogen#infect()
set nobackup
set history=200
syntax on
filetype plugin indent on
set colorcolumn=121 " Margin on the right
set number " Show line numbers on the left
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
compiler ruby         " Enable compiler support for ruby

autocmd Filetype ruby,yaml setlocal ts=2 sw=2 expandtab
au BufNewFile,BufRead *.gec,Guardfile set filetype=ruby
au BufNewFile,BufRead *.gv set filetype=dot
autocmd Filetype sh setlocal ts=2 sw=2 expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
"
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
set background=dark
let g:solarized_termcolors=256
"colorscheme solarized
colorscheme vibrantink
" set cursorline
autocmd Filetype yaml colorscheme wuye
autocmd Filetype yaml :CSApprox

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
augroup WhitespaceMatch
  " Remove ALL autocommands for the WhitespaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END
function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hotkeys
"
" F2 toggles line numbers on the left
map <silent> <F2> :set nu!<CR>
" F3 toggles paste mode
map <F3> :set paste!<BAR>:set paste?<CR>
" F4 toggles word-wrap
map <F4> :set wrap!<BAR>:set wrap?<CR>
" F5 toggles word-wrap
map <F5> :set hlsearch!<BAR>:set hlsearch?<CR>
" F12 removes trailing whitespace
map <F12> :perldo s/\s+$//
" CTRL-H gets ready for a search & replace with perl regex
map <C-H> :perldo s/

" CTRL-M, i/I creates a new RSpec test
map <C-M>I O}<Esc>Oit(""){<Esc>hhi
map <C-M>i j<C-M>I
" CTRL-M, c/C creates a new RSpec context
map <C-M>C :set nopaste<CR>Ocontext '' do<CR>end<Esc>kf'a
map <C-M>c j<C-M>C
