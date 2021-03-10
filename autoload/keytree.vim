" Pragma once {{{1
if exists('g:keytree_loaded')
	finish
endif

let g:keytree_loaded = 1
"}}}1

" Run a node's action {{{1
function! keytree#RunNode (node) abort
	if has_key(a:node, 'action')
		exec a:node['action']

	elseif has_key(a:node, 'action-args')
		call feedkeys(a:node['action-args'])
	endif
endfunction
" }}}1

" Browse the key tree {{{1
function! keytree#Browse () abort
	let l:continue     = v:true
	let l:current_node = g:keytree#treenodes#root
	let l:node_history = []
	let l:kt_window    = {}

	while continue
		let l:kt_window   = keytree#window#Show(l:kt_window, l:current_node)
		redraw
		let l:pressed_key = nr2char(getchar())

		if l:pressed_key == "\<Esc>"
			call keytree#window#Kill(l:kt_window)
			let l:continue = v:false
		else
			if l:pressed_key == "-" && !empty(l:node_history)
				let l:current_node = l:node_history[-1]
				call remove(l:node_history, -1)
			else
				if has_key(current_node['children'], l:pressed_key)
					let l:next_child = get(l:current_node['children'], l:pressed_key)

					if has_key(next_child, 'children')
						let l:node_history = add(l:node_history, l:current_node)
						let l:current_node = l:next_child
					else
						call keytree#window#Kill(l:kt_window)
						call keytree#RunNode(l:next_child)
						let l:continue = v:false
					endif
				endif
			endif
		endif
	endwhile
endfunction
" }}}1
