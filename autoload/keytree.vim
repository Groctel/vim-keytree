" Pragma once {{{1
if exists('g:keytree_loaded')
	finish
endif

let g:keytree_loaded = 1
"}}}1

" EXIT : Kill the last window and signal the loop to stop {{{1
function! keytree#_Exit (tree_info) abort
	let l:tree_info = a:tree_info

	call keytree#window#Kill(l:tree_info['kt_window'])
	let l:tree_info['continue'] = v:false

	return l:tree_info
endfunction
" }}}1

" REWIND : Move to the node's parent (last history item) {{{1
function! keytree#_Rewind (tree_info) abort
	let l:tree_info = a:tree_info

	if !empty(l:tree_info['node_history'])
		let l:tree_info['current_node'] = l:tree_info['node_history'][-1]
		call remove(l:tree_info['node_history'], -1)
	endif

	return l:tree_info
endfunction
" }}}1

" RUN NODE : Execute a node's action {{{1
function! keytree#_RunNode (node) abort
	if has_key(a:node, 'action')
		exec a:node['action']

	elseif has_key(a:node, 'action-args')
		call feedkeys(a:node['action-args'])
	endif
endfunction
" }}}1

" ADVANCE : Move to the next child or run it (if it exists) {{{1
function! keytree#_Advance (tree_info, pressed_key) abort
	let l:tree_info = a:tree_info

	let l:children = get(tree_info['current_node'], 'children')

	if has_key(l:children, a:pressed_key)
		let l:next_child = get(l:children, a:pressed_key)

		if has_key(l:next_child, 'children')
			let l:node_history = add(
				\ l:tree_info['node_history'],
				\ l:tree_info['current_node']
			\)
			let l:tree_info['current_node'] = l:next_child

		else
			call keytree#window#Kill(l:tree_info['kt_window'])
			call keytree#_RunNode(l:next_child)
			let l:tree_info['continue'] = v:false
		endif
	endif

	return l:tree_info
endfunction
" }}}1

" BROWSE : Main loop to browse the tree with the user's input {{{1
function! keytree#Main () abort
	let l:tree_info  = {
		\ 'current_node' : g:keytree#treenodes#root,
		\ 'node_history' : [],
		\ 'kt_window'    : {},
		\ 'continue'     : v:true
	\}

	while tree_info['continue']
		let l:tree_info['kt_window'] = keytree#window#DisplayNode(
			\ l:tree_info['kt_window'],
			\ l:tree_info['current_node']
		\)
		redraw

		let l:pressed_key = nr2char(getchar())

		if l:pressed_key == "\<Esc>"
			let l:tree_info = keytree#_Exit(l:tree_info)

		elseif l:pressed_key == "-"
			let l:tree_info = keytree#_Rewind(l:tree_info)

		else
			let l:tree_info = keytree#_Advance(l:tree_info, l:pressed_key)
		endif
	endwhile
endfunction
" }}}1
