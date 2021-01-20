" Vim filetype plugin
" Language:     qmake
" Maintainer:   matveyt
" Last Change:  2021 Jan 20
" License:      VIM License
" URL:          https://github.com/matveyt/vim-qmake

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setl ai< si< cinw< com< cms< def< fo< inc< isk<'
setlocal autoindent smartindent cinwords=
setlocal comments=:# commentstring=#\ %s
setlocal define=\\<define\\%(Test\\|Replace\\)\\>
setlocal formatoptions-=t formatoptions+=croqj
setlocal include=\\<include(
setlocal iskeyword=@,48-57,_,.
