" Default tree nodes

" Buffer nodes {{{1
let s:child_b_a = {
	\ 'name'        : 'Add',
	\ 'action-args' : ':badd '
\}

let s:child_b_d = {
	\ 'name'   : 'Delete',
	\ 'action' : ':bdel'
\}

let s:child_b_n = {
	\ 'name'   : 'Next',
	\ 'action' : ':bnext'
\}

let s:child_b_p = {
	\ 'name'   : 'Previous',
	\ 'action' : ':bprev'
\}

let s:child_b_w = {
	\ 'name'   : 'Write',
	\ 'action' : ':write'
\}

let s:child_b = {
	\ 'name'     : 'Buffer',
	\ 'children' : {
		\ 'a' : s:child_b_a,
		\ 'd' : s:child_b_d,
		\ 'n' : s:child_b_n,
		\ 'p' : s:child_b_p,
		\ 'w' : s:child_b_w
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

" Help nodes {{{1
let s:child_h_h = {
	\ 'name'        : 'Horizontal',
	\ 'action-args' : ':help '
\}

let s:child_h_v = {
	\ 'name'        : 'Vertical',
	\ 'action-args' : ':vert help '
\}

let s:child_h = {
	\ 'name'     : 'Help',
	\ 'children' : {
		\ 'h' : s:child_h_h,
		\ 'v' : s:child_h_v
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

let s:child_w_w = {
	\ 'name'   : 'Next in sequence',
	\ 'action' : ':normal ^W^W'
\}

let s:child_w = {
	\ 'name'     : 'Window',
	\ 'children' : {
		\ 'q' : s:child_w_q,
		\ 'w' : s:child_w_w
	\}
\}
" }}}1

let g:keytree#treenodes#root = {
	\ 'name'     : 'vim-Keytree: Press a key to continue',
	\ 'children' : {
		\ 'b' : s:child_b,
		\ 'f' : s:child_f,
		\ 'F' : s:child_F,
		\ 'h' : s:child_h,
		\ 'q' : s:child_q,
		\ 'w' : s:child_w
	\}
\}
