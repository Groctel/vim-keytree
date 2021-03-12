" PRINT KEYS : Show a node's children and keys inside the window {{{1
function! keytree#window#_PrintKeys (kt_window, node) abort
	let l:row = 2
	let l:children = keytree#window#_SortKeys(a:node['children'])

	for key in l:children
		let l:line = '[' . key . '] ' . get(a:node['children'], key)['name']

		call nvim_buf_set_text(
			\ a:kt_window['buffer'],
			\ l:row,
			\ 2,
			\ l:row,
			\ 2 + len(l:line),
			\ [l:line]
		\)

		let l:row += 1
	endfor
endfunction
" }}}1

" PRINT TITLE : Print the node's name at the top of the window {{{1
function! keytree#window#_PrintTitle (kt_window, node) abort
	call nvim_buf_set_text(
		\ a:kt_window['buffer'],
		\ 0,
		\ 2,
		\ 0,
		\ 2 + len(a:node['name']),
		\ [toupper(a:node['name'])]
	\)
endfunction
" }}}1

" SORT KEYS : Sort the keys alphabetically, upper case after lower {{{1
function! keytree#window#_SortKeys (node) abort
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

" SPAWN : Create and open the window and draw its borders {{{1
function! keytree#window#_Spawn (node) abort
	let l:kt_window  = {}
	let l:ui         = nvim_list_uis()[0]
	let l:win_width  = l:ui.width
	let l:win_height = len(keys(a:node['children'])) + 4

	let l:kt_window['buffer'] = nvim_create_buf(v:false, v:true)

	let l:config = {
		\ 'relative' : 'editor',
		\ 'anchor'   : 'SW',
		\ 'width'    : l:win_width,
		\ 'height'   : l:win_height,
		\ 'col'      : 0,
		\ 'row'      : l:ui.height,
		\ 'style'    : 'minimal',
	\}

	let l:kt_window['id'] = nvim_open_win(
		\ l:kt_window['buffer'],
		\ v:true,
		\ l:config
	\)

	let l:horizontal_border = '+' . repeat('-', l:win_width - 2) . '+'
	let l:vertical_border   = '|' . repeat(' ', l:win_width - 2) . '|'

	let l:win_border = flatten([
		\ l:horizontal_border,
		\ map(range(l:win_height-2), 'vertical_border'),
		\ l:horizontal_border
	\])

	call nvim_buf_set_lines(l:kt_window['buffer'], 0, -1, v:false, l:win_border)

	return l:kt_window
endfunction
" }}}1

" KILL : Close a window and delete its associated buffer {{{1
function! keytree#window#Kill (kt_window) abort
	call nvim_win_close(a:kt_window['id'], v:true)
	call nvim_buf_delete(a:kt_window['buffer'], {})
endfunction
" }}}1

" DISPLAY NODE : Show a node's information (name and children) in a window {{{1
function! keytree#window#DisplayNode (previous_kt_window, node) abort
	let l:kt_window = keytree#window#_Spawn(a:node)

	call keytree#window#_PrintTitle(l:kt_window, a:node)
	call keytree#window#_PrintKeys(l:kt_window, a:node)

	if !empty(a:previous_kt_window)
		call keytree#window#Kill(a:previous_kt_window)
	endif

	return l:kt_window
endfunction
" }}}1
