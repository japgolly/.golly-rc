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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
"
au BufNewFile,BufRead *.gec,Guardfile set filetype=ruby
au BufNewFile,BufRead *.gv            set filetype=dot
au filetype ruby,yaml,sh              setlocal ts=2 sw=2 expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
"
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
set background=dark
let g:solarized_termcolors=256
"colorscheme solarized
colorscheme vibrantink
" set cursorline

"autocmd BufEnter * if match(@%:p,'.*/test/.*')>=0 | colorscheme autumnleaf | end
"au BufEnter * if match(expand('%:p'),'.*/test/.*')>=0 | colorscheme autumnleaf | CSApprox | end
au filetype yaml                      colorscheme dante | CSApprox
au filetype markdown                  colorscheme desert256 | CSApprox

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

" CTRL-/ adds comments
map  <silent>  :s/^\(\s*.\)/#\1/<CR>:set nohlsearch<CR>
imap <silent>  <Esc>w

" CTRL-\ removes comments
map  <silent>  :s/^\(\s\s*#\s*\\|\s*#\s\s*\\|\(\s*\)#\(.*\)\)$/\2\3/<CR>:set nohlsearch<CR>
imap <silent>  <C-O>

" ,s splits line so that cursor becomes the beginning of the next line (and
"                        whitespace around cursor is removed)
nmap <silent> ,s :set nohlsearch<BAR>:set nopaste<CR>i<CR><Esc>k:s/[ \t;]*$//<CR>jw
" ,S expands a line like "def asd; <cursor here> abc(123); end" into 3 lines
nmap <silent> ,S ,s$b,skkw

"-----------------------------------------------------------------
" RSpec macros
"
" ,r[dD] - New describe
nmap ,rD :set nopaste<CR>Odescribe " do<CR>end<Esc>kf"s
nmap ,rd j,rD
" ,r[cC] - New context
nmap ,rC :set nopaste<CR>Ocontext "" do<CR>end<Esc>kf"a
nmap ,rc j,rC
" ,r[iI] - New test (with impl)
nmap <silent> ,rI :set nopaste<CR>O}<Esc>Oit(""){<Esc>hhi
nmap <silent> ,ri j,rI
" ,r[pP] - New test (pending)
nmap <silent> ,rP :set nopaste<CR>Oit("")<Esc>hi
nmap <silent> ,rp j,rP
" ,rx - Expand pending test
nmap <silent> ,rx :set nopaste<CR>A{<Esc>o}<CR><Esc>kO

"-----------------------------------------------------------------
" Comment macros
"
" code seperation comments
nmap <silent> ,C- :set paste<CR>O<Esc>:set nopaste<CR>O#----------------------------------------------------------------------------------------------------------------------------<Esc>0120lD0jjw
nmap <silent> ,c- j,C-0kkw
" method doco
nmap <silent> ,cD :set nopaste<CR>O#<CR><CR> @param <CR>@return <Esc>kkkA<SPACE>
nmap <silent> ,Cd ,cD
nmap <silent> ,cd j,cD
" @!visibility private declarations
nmap <silent> ,cVP :set nopaste<CR>O# @!visibility private<Esc>0jw
nmap <silent> ,Cvp ,cVP
nmap <silent> ,cVp ,cVP
nmap <silent> ,cvP ,cVP
nmap <silent> ,cvp j,cVP

"-----------------------------------------------------------------
" Markdown macros
nmap ,mdd a ![Done](done.png)<Esc>
nmap ,mdD $,mdd
nmap ,mdq a ![?](question.png)<Esc>
nmap ,mdQ $,mdq

"-----------------------------------------------------------------
" Ruby macros
nmap ,rce :set nopaste<CR>oclass_eval <<-EOB<CR>EOB<Esc>O<Space><Space>

"-----------------------------------------------------------------
function! Hehe()
	let dir = expand('%:p:h')
	let dir = substitute(dir, '/\?$', '/', '') " make it end in /
	let filename = expand('%:t')
"echo 'dir = '.dir
"echo 'filename = '.filename
"echo '-------------------------------------'

"let dir = '/home/golly/projects/corvid/lib/corvid/generators'
"let filename = 'base.rb'

"let dir = '/home/golly/projects/corvid/test/spec/generators'
"let filename = 'base_spec.rb'

	let f = ''
	let open_window_dir = 'rightbelow'
	if dir =~ '/lib/'
		let root = substitute(dir, '/lib/.*$', '', '')
		let path = substitute(dir, '^.*/lib/', '', '')
		let path2 = substitute(path, '^[^/]*\(/\|$\)', '', '') " optional - strips corvid
"echo 'root = '.root
"echo 'path = '.path
"echo 'path2 = '.path2
"echo '________'

		if f == '' | let f = Hehe_try1(root, path2, filename) | endif
		if f == '' | let f = Hehe_try1(root, path, filename) | endif

	elseif dir =~ '/test/spec/'
		let open_window_dir = 'leftabove'
		let root = substitute(dir, '/test/spec/.*$', '', '')
		let path = substitute(dir, '^.*/test/spec/', '', '')
		if f == '' | let f = Hehe_try1_t2l(root, path, filename, '_spec\.rb') | endif
	endif

	"echo 'Final result = '.f
	if f != ''
		call JumpToOrOpenFile(f, open_window_dir, root)
	endif
endfunction

function! JumpToOrOpenFile(filename, open_window_dir, root)
	"echo 'Opening...'
	"echo 'a:filename = '.a:filename
	let f = simplify(fnamemodify(a:filename, ':p'))
	"echo 'f = '.f
	"let f = substitute(f, '///*', '/', '')

	let cmd = ''
	let i = bufnr('$')
	while i > 0
		if bufloaded(i)
			"echo i.' - '.bufname(i)
			let bf = simplify(fnamemodify(bufname(i), ':p'))
			"echo i.' - '.bf
			"echo (bf == f)
			"echo
			if bf == f
				let cmd = bufwinnr(i).'wincmd w'
				break
			end
		endif
		let i -= 1
	endwhile

	if cmd == ''
		let root = simplify(fnamemodify(a:root, ':p'))
		let root = substitute(a:root, '/\?$', '/', '') " make it end in /
		let f = substitute(f, root, '', '')
		"echo 'root = '.root
		"echo 'file to open = '.f
		let cmd = a:open_window_dir.' vsp '.f
	end

	"echo 'cmd = '.cmd | echo ''
	execute cmd
endfunction

function! Hehe_try1_t2l(root, path, filename, suf1)
	let root = substitute(a:root, '/\?$', '/', '') " make it end in /
	let path = substitute(a:path, '/\?$', '/', '') " make it end in /
	let f = ''
	if f == '' | let f = Hehe_try2(root, path, a:filename, a:suf1, 'lib', '.rb') | endif
	"echo 'root - '.root
	if f == ''
		for d in split(globpath(root.'lib','*'), '\n')
			let d = substitute(d, root, '', '')
			"echo '>> '.d
			if f == '' | let f = Hehe_try2(root, path, a:filename, a:suf1, d, '.rb') | endif
		endfor
	endif
	" glob
	return f
endfunction

function! Hehe_try1(root, path, filename)
	let root = substitute(a:root, '/\?$', '/', '') " make it end in /
	let path = substitute(a:path, '/\?$', '/', '') " make it end in /
	let f = ''
	if f == '' | let f = Hehe_try2(root, path, a:filename, '\.rb$', 'test/unit', '_unit.rb') | endif
	if f == '' | let f = Hehe_try2(root, path, a:filename, '\.rb$', 'test/spec', '_spec.rb') | endif
	if f == '' | let f = Hehe_try2(root, path, a:filename, '\.rb$', 'test', '_unit.rb') | endif
	if f == '' | let f = Hehe_try2(root, path, a:filename, '\.rb$', 'spec', '_spec.rb') | endif
	return f
endfunction

function! Hehe_try2(root, path, filename, suf1, dir, suffix)
	let filename = substitute(a:filename, a:suf1, a:suffix, '')
	let try = a:root.a:dir.'/'.a:path.filename
	"echo 'root='.a:root
	"echo 'path='.a:path
	"echo 'filename='.a:filename
	"echo 'try='.try
	"echo '____________________________________________________________'
	"echo filereadable(try)

	return filereadable(try) ? try : ''
endfunction

nmap  call Hehe()<CR>
