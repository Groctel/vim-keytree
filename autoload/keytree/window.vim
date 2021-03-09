function! keytree#window#Kill (kt_window) abort
	call nvim_win_close(a:kt_window['id'], v:true)
	call nvim_buf_delete(a:kt_window['buffer'], {})
endfunction

function! keytree#window#PrintKeys (kt_window, node) abort
	let l:row = 2
	let l:children = keytree#window#SortKeys(a:node['children'])

	for key in l:children
		let l:line = '[' . key . '] ' . get(a:node['children'], key)['name']

		call nvim_buf_set_text(
			\ a:kt_window['buffer'],
			\ l:row,
			\ 2,
			\ l:row,
			\ 2 + len(l:line),
			\ [line]
		\)

		let l:row += 1
	endfor
endfunction

function! keytree#window#PrintTitle (kt_window, node) abort
	call nvim_buf_set_text(
		\ a:kt_window['buffer'],
		\ 0,
		\ 2,
		\ 0,
		\ 2 + len(a:node['name']),
		\ [toupper(a:node['name'])]
	\)
endfunction

" Sort the keys alphabetically, upper case after lower {{{1
function! keytree#window#SortKeys (node) abort
	let l:keys = []

	for key in keys(a:node)
		let l:keys = add(l:keys, tolower(key))
	endfor

	let l:keys = sort(l:keys)
	let l:i    = 1

	while l:i < len(keys)
		if l:keys[i] == l:keys[i-1]
			let l:keys[i] = toupper(l:keys[i])
		endif

		let l:i += 1
	endwhile

	return l:keys
endfunction
" }}}1

function! keytree#window#Spawn (node) abort
	let l:kt_window = {}

	let l:ui     = nvim_list_uis()[0]
	let l:width  = l:ui.width
	let l:height = len(keys(a:node['children'])) + 4

	let l:kt_window['buffer'] = nvim_create_buf(v:false, v:true)
	let l:kt_window['config'] = {
		\ 'relative' : 'editor',
		\ 'anchor'   : 'SW',
		\ 'width'    : l:width,
		\ 'height'   : l:height,
		\ 'col'      : 0,
		\ 'row'      : l:ui.height,
		\ 'style'    : 'minimal',
	\}

	let l:kt_window['id'] = nvim_open_win(
		\ l:kt_window['buffer'],
		\ v:true,
		\ l:kt_window['config']
	\)

	let l:horizontal = '+' . repeat('-', width - 2) . '+'
	let l:vertical   = '|' . repeat(' ', width - 2) . '|'
	let l:win_border = flatten([
		\ l:horizontal,
		\ map(range(l:height-2), 'vertical'),
		\ l:horizontal
	\])

	call nvim_buf_set_lines(l:kt_window['buffer'], 0, -1, v:false, l:win_border)

	return l:kt_window
endfunction

" Display a node's information (name and children) {{{1
function! keytree#window#Show (previous_kt_window, node) abort
	if !empty(a:previous_kt_window)
		call keytree#window#Kill(a:previous_kt_window)
	endif

	let l:kt_window = keytree#window#Spawn(a:node)

	call keytree#window#PrintTitle(l:kt_window, a:node)
	call keytree#window#PrintKeys(l:kt_window, a:node)

	return l:kt_window
endfunction
" }}}1

