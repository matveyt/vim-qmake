" Vim filetype plugin
" Language:     qmake
" Maintainer:   matveyt
" Last Change:  2021 Jan 27
" License:      VIM License
" URL:          https://github.com/matveyt/vim-qmake

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setl com< cms< def< fen< fdm< fo< inc< isk<'
setlocal comments=:# commentstring=#\ %s
setlocal define=\\<define\\%(Test\\\|Replace\\)\\>
setlocal foldenable foldmethod=indent
setlocal formatoptions-=t formatoptions+=croqj
setlocal include=\\<include(
setlocal iskeyword=@,48-57,_,.
