" Pragma once {{{1
if exists('g:keytree_loaded')
	finish
endif

let g:keytree_loaded = 1
"}}}1

" Sort the keys alphabetically, upper case after lower {{{1
function! keytree#SortKeys(node) abort
	let l:keys = []

	for key in keys(a:node['children'])
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

" Display a node's information (name and children) {{{1
function! keytree#DisplayNode(node) abort
	echo a:node['name']

	if has_key(a:node, 'children')
		let l:keys = keytree#SortKeys(a:node)

		let l:i = 0

		while l:i < len(keys)
			echo '  - [' . keys[i] . '] : ' . get(a:node['children'], keys[i])['name']
			let l:i += 1
		endwhile
	endif

	echo "\n"
endfunction
" }}}1

" Run a node's action {{{1
function! keytree#RunNode(node) abort
	if has_key(a:node, 'action')
		exec a:node['action']

	elseif has_key(a:node, 'action-args')
		call feedkeys(a:node['action-args'])
	endif
endfunction
" }}}1

" Browse the key tree {{{1
function! keytree#Browse() abort
	call keytree#DisplayNode(g:keytree#treenodes#root)

	let l:continue     = v:true
	let l:current_node = g:keytree#treenodes#root
	let l:node_history = []
	let l:pressed_key  = nr2char(getchar())

	while l:continue && l:pressed_key != "\<Esc>"
		if l:pressed_key == "-" && !empty(l:node_history)
			let l:current_node = l:node_history[-1]
			call remove(l:node_history, -1)
		else
			if has_key(l:current_node['children'], l:pressed_key)
				let l:next_child = get(l:current_node['children'], l:pressed_key)

				if has_key(l:next_child, 'children')
					let l:node_history = add(l:node_history, l:current_node)
					let l:current_node = l:next_child
				else
					call keytree#RunNode(l:next_child)
					let l:continue = v:false
				endif
			endif
		endif

		if l:continue
			call keytree#DisplayNode(l:current_node)
			let l:pressed_key = nr2char(getchar())
		endif
	endwhile
endfunction
" }}}1
