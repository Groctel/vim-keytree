" Window nodes {{{1
let s:child_w_q = {
	\ 'name'   : 'Quit',
	\ 'action' : 'quit'
\}

let s:child_w = {
	\ 'name'     : 'Window',
	\ 'children' : {
		\ 'q' : s:child_w_q
	\}
\}
" }}}1

" Buffer nodes {{{1
let s:child_b_o = {
	\ 'name'        : 'Open',
	\ 'action-args' : ':badd '
\}

let s:child_b = {
	\ 'name'     : 'Buffer',
	\ 'children' : {
		\ 'o' : s:child_b_o
	\}
\}
" }}}1

let g:keytree#treenodes#root = {
	\ 'name'     : 'root',
	\ 'children' : {
		\ 'b' : s:child_b,
		\ 'w' : s:child_w
	\}
\}
