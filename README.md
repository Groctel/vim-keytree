# vim-keytree

**A universe of actions at your fingertips!**

## What does keytree do?

Do you know how SpaceVim lets you press `<Space>` to make a menu appear with lots of options at your disposition to navigate around?
This plugin is a serious attempt to emulate that behaviour while making it extensible and simple to use.

**This plugin is still in alpha stage:** Right now this is a rough draft of what keytree will become.
Please be patient or check the TODO list and start pull request!

## How to use keytree

Start browsing the tree with `:KTBrowse`.
Press the shown keys to advance through the tree and run an action.
Press `-` to return to the previos node and `<Esc>` to exit without running any actions.

Ideally, you should map a key to access the tree as quick as possible:

```vim
nmap <Space> :KTBrowse<CR>
```

## TODO list

- [ ] Document the tree structure.
- [ ] Set global variables for keys.
- [ ] Tree editing interface.
- [x] Redraw output for every node.
- [x] Draw output in a proper window.
- [ ] Colored output.
