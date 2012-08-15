"_______________________________________________________________________________________________________________________
"
" Jumps from impl -> test, or test -> impl
"_______________________________________________________________________________________________________________________
function! JumpImplTest()
	let dir = substitute(expand('%:p:h'), '/\?$', '/', '')
	let filename = expand('%:t')
	let open_window_dir = 'leftabove'
	let f = ''

	" Find corresponding impl or test
	if dir =~ '/lib/'
		let open_window_dir = 'rightbelow'
		let root = substitute(dir, '/lib/.*$', '', '')
		let path = substitute(dir, '^.*/lib/', '', '')
		let path2 = substitute(path, '^[^/]*\(/\|$\)', '', '') " optional, strips lib name
		if f == '' | let f = JumpImplTest__find_test(root, path2, filename) | endif
		if f == '' | let f = JumpImplTest__find_test(root, path, filename) | endif
	else
		if f == '' | let [f,root] = JumpImplTest__find_impl(dir, filename, '/test/unit/', '_test\.rb') | endif
		if f == '' | let [f,root] = JumpImplTest__find_impl(dir, filename, '/test/spec/', '_spec\.rb') | endif
		if f == '' | let [f,root] = JumpImplTest__find_impl(dir, filename, '/spec/',      '_spec\.rb') | endif
		if f == '' | let [f,root] = JumpImplTest__find_impl(dir, filename, '/test/',      '_test\.rb') | endif
	endif

	" Open file
	if f != ''
		call JumpToOrOpenFile(f, open_window_dir, root)
	else
		echo 'Unable to find matching impl/test for '.dir.filename
	endif
endfunction

" Try to find a corresponding impl
function! JumpImplTest__find_impl(dir, filename, test_dir_frag, suffix)
	let f = ''
	if a:dir =~ a:test_dir_frag
		let root = substitute(a:dir, a:test_dir_frag.'.*$', '', '')
		let path = substitute(a:dir, '^.*'.a:test_dir_frag, '', '')
		if a:filename =~ a:suffix
			let f = JumpImplTest__try(root, path, a:filename, a:suffix, 'lib', '.rb')

			" Still not found - check if the library name is omitted in test dir structure
			" eg. lib/ABC/cli/main.rb <--> test/spec/cli/main_spec.rb
			if f == ''
				for d in split(globpath(root.'/lib','*'), '\n')
					if isdirectory(d)
						let d = substitute(d, root.'/*' , '', '')
						if f == '' | let f = JumpImplTest__try(root, path, a:filename, a:suffix, d, '.rb') | endif
					endif
				endfor
			endif
		endif
	endif
	return f == '' ? ['',''] : [f,root]
endfunction

" Try to find a corresponding test
function! JumpImplTest__find_test(root, path, filename)
	let f = ''
	if f == '' | let f = JumpImplTest__try(a:root, a:path, a:filename, '\.rb$', 'test/unit', '_test.rb') | endif
	if f == '' | let f = JumpImplTest__try(a:root, a:path, a:filename, '\.rb$', 'test/spec', '_spec.rb') | endif
	if f == '' | let f = JumpImplTest__try(a:root, a:path, a:filename, '\.rb$', 'spec', '_spec.rb') | endif
	if f == '' | let f = JumpImplTest__try(a:root, a:path, a:filename, '\.rb$', 'test', '_test.rb') | endif
	return f
endfunction

" Build a new filename and check if it exists
function! JumpImplTest__try(root, path, filename, suffix, new_dir, new_suffix)
	let filename = substitute(a:filename, a:suffix, a:new_suffix, '')
	let try = a:root.'/'.a:new_dir.'/'.a:path.'/'.filename
	return filereadable(try) ? try : ''
endfunction

"_______________________________________________________________________________________________________________________
"
" Opens a new file, unless already open in which case it makes it the current window
"_______________________________________________________________________________________________________________________
function! JumpToOrOpenFile(filename, open_window_dir, root)
	let f = simplify(fnamemodify(a:filename, ':p'))
	let cmd = ''

	" Check if already open
	let i = bufnr('$')
	while i > 0
		if bufloaded(i)
			let bf = simplify(fnamemodify(bufname(i), ':p'))
			if bf == f
				let cmd = bufwinnr(i).'wincmd w'
				break
			end
		endif
		let i -= 1
	endwhile

	" If not already open, just open it
	if cmd == ''
		let root = simplify(fnamemodify(a:root, ':p'))
		let root = substitute(a:root, '/\?$', '/', '') " make it end in /
		let f2 = substitute(f, root, '', '')
		if filereadable(f2) | let f = f2 | endif
		let cmd = a:open_window_dir.' vsp '.f
	end

	" Focus or open file
	execute cmd
endfunction

