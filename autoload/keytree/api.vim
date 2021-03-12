" INIT : Initialise the api_info the default values an the passed path {{{1
function! keytree#api#_Init (path) abort
	let l:api_info = {
		\ 'continue'     : v:true,
		\ 'current_node' : g:keytree#treenodes#root,
		\ 'path'         : a:path
	\}

	return l:api_info
endfunction
" }}}1

" TRAVERSE TREE : Avance throught the keytree guided by the path {{{1
function! keytree#api#_TraverseTree (api_info, path) abort
	let l:api_info = a:api_info
	let l:path     = a:path

	while !empty(l:path) && l:api_info['continue']
		if has_key(get(l:api_info['current_node'], 'children'), l:path[0])
			let l:api_info['current_node'] = get(
				\ l:current_node['current_node'])['children'], l:path[0]
			\)
			call remove(l:path, 0)
		else
			echo "Invalid path. Error found at " . string(l:path)
			let l:api_info['continue'] = v:false
		endif
	endwhile

	return l:api_info
endfunction
" }}}1

" ADD KEY : Add a key and a node to the last node of path {{{1
function! keytree#api#AddKey (key, node, path) abort
	let l:api_info = keytree#api#_Init(a:path)
	let l:api_info = keytree#api#_TraverseTree(l:api_info, a:path)

	if l:api_info['continue']
		if !has_key(l:api_info['current_node'], 'children')
			echo "Could not add key to " . get(l:api_info['current_node'], 'name') . ": no 'children'!"
		else
			let l:parent        = get(l:api_info['current_node'], 'children')
			let l:parent[a:key] = a:node
		endif
	endif
endfunction
" }}}1

" REMOVE KEY : Remove the child key from the last node of path {{{1
function! keytree#api#RemoveKey (key, path) abort
	let l:api_info = keytree#api#_Init(a:path)
	let l:api_info = keytree#api#_TraverseTree(l:api_info, a:path)

	if l:api_info['continue']
		if !has_key(l:api_info['current_node'], 'children')
			echo "Could not remove key from " . get(l:api_info['current_node'], 'name') . ": no 'children'!"
		else
			let l:parent = get(l:api_info['current_node'], 'children')
			call remove(l:parent, a:key)
		endif
	endif
endfunction
" }}}1
