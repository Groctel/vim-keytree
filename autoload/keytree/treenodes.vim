" Default tree nodes

" Buffer nodes {{{1
let s:child_b_d = {
	\ 'name'   : 'Delete',
	\ 'action' : ':bdel'
\}

let s:child_b_o = {
	\ 'name'        : 'Open',
	\ 'action-args' : ':badd '
\}

let s:child_b = {
	\ 'name'     : 'Buffer',
	\ 'children' : {
		\ 'd' : s:child_b_d,
		\ 'o' : s:child_b_o
	\}
\}
" }}}1

" Folding nodes {{{1
let s:child_f_c = {
	\ 'name'   : 'Open folding',
	\ 'action' : ':normal zo'
\}

let s:child_f_o = {
	\ 'name'   : 'Close folding',
	\ 'action' : ':normal zc'
\}

let s:child_f = {
	\ 'name'     : 'Folding',
	\ 'children' : {
		\ 'c' : s:child_f_c,
		\ 'o' : s:child_f_o
	\}
\}
" }}}1

" File nodes {{{1
let s:child_F_c = {
	\ 'name'   : 'vimrc',
	\ 'action' : ':badd $MYVIMRC'
\}

let s:child_F = {
	\ 'name'     : 'File',
	\ 'children' : {
		\ 'c' : s:child_F_c
	\}
\}
" }}}1

" Quit vim nodes {{{1
let s:child_q_f = {
	\ 'name'   : 'Force quit vim',
	\ 'action' : ':qa!'
\}

let s:child_q_q = {
	\ 'name'   : 'Quit vim',
	\ 'action' : ':qa'
\}

let s:child_q_w = {
	\ 'name'   : 'Write quit vim',
	\ 'action' : ':wqa'
\}

let s:child_q = {
	\ 'name'     : 'Quit vim',
	\ 'children' : {
		\ 'f' : s:child_q_f,
		\ 'q' : s:child_q_q,
		\ 'w' : s:child_q_w
	\}
\}
" }}}1

" Window nodes {{{1
let s:child_w_q = {
	\ 'name'   : 'Quit',
	\ 'action' : ':quit'
\}

let s:child_w = {
	\ 'name'     : 'Window',
	\ 'children' : {
		\ 'q' : s:child_w_q
	\}
\}
" }}}1

let g:keytree#treenodes#root = {
	\ 'name'     : 'root',
	\ 'children' : {
		\ 'b' : s:child_b,
		\ 'f' : s:child_f,
		\ 'F' : s:child_F,
		\ 'q' : s:child_q,
		\ 'w' : s:child_w
	\}
\}
