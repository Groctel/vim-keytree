# vim-keytree

**A universe of actions at your fingertips!**

### Beta release!

This plugin is in Beta stage.
This means that it is fully usable but still needs some improvements.
Please check the TODO list at the bottom of the document and open issues or pull requests.
Other than that, please enjoy!

**Since this is no longer in alpha stage every change made from now on will be backwards compatible**.

## What does Keytree do?

Do you know how SpaceVim lets you press `<Space>` to make a menu appear with lots of options at your disposition to navigate around?
This plugin is a serious attempt to emulate that behaviour while making it extensible and simple to use.

## Installation

Use the plugin manager of your choice. I like [vim-plug](https://github.com/junegunn/vim-plug).

```vim
Plug 'Groctel/vim-keytree'
```

This plugin uses Neovim's window api, so the plugin doesn't work with Vim.

## How to use Keytree

### Broswing the tree

Start browsing the tree with `:Keytree`.
Press the shown keys to advance through the tree and run an action.
Press `<BS>` to return to the previos node and `<Esc>` to exit without running any actions.

Ideally, you should map a key to access the tree as quick as possible:

```vim
nnoremap <Space> :Keytree<CR>
```

A global reference to the tree's root node is saved at `g:keytree#treenodes#root`.

### Editing the tree

Keytree provides a simple API to help you add and remove keys from the tree:

```vim
function! keytree#api#AddKey (key, node, path) abort
function! keytree#api#RemoveKey (key, path) abort
```

These functions accept the following arguments:

- **`key`:**  The key to be added to the tree (eg. `'d'` for `delete`).
- **`node`:** The node (a dict) to add to the tree (eg. `s:child_n_d`).
- **`path`:** The path to the parent node from the root (eg `['j', 'c']` or `[]` for root).

As an example, consider the following tree structure:

```
root
|---b
    |---a
    |---d
    |---n
|---f
    |---o
        |---k
|---q
    |---q
```

These are valid calls:

```vim
" Add a 'p' node to the root of the tree
call keytree#api#AddKey ('p', s:child_p, [])

" Add a 'j' node after to the 'fo' node
call keytree#api#AddKey ('j', s:child_f_o_j, ['f', 'o'])

" Remove the 'b' subtree entirely
call keytree#api#RemoveKey ('b', [])

" Remove the 'q' leaf node from the 'q' node
call keytree#api#RemoveKey ('q', ['q'])
```

You can, of course, create your own tree and just `AddKey` its root to the global tree.
Invalid calls will return an error if one of the nodes in `path` (even the last one) is missing the `'children'` dict.

## Is there something preventing me from creating a full graph, cicles and all?

Nope.
Feel free to experiment!
With a little skill you can use Keytree as a choose your own adventure text game engine!
(Please keep in mind that being able to doesn't translate to being required to).

## TODO list

- [ ] Colored output.
- [ ] Add more keys (open issues with ideas!).
- [ ] Horizontal sorting.
- [ ] Fix `:normal` keyfeeds (probably need to return to the previous window before running).

- [x] Document the tree structure.
- [x] Tree editing interface.
- [x] Redraw output for every node.
- [x] Draw output in a proper window.
