" Vim indent file
" Language:     qmake
" Maintainer:   matveyt
" Last Change:  2021 Jan 23
" License:      VIM License
" URL:          https://github.com/matveyt/vim-qmake

if exists('b:did_indent')
    finish
endif
let b:did_indent = 1

let b:undo_indent = 'setl inde< indk<'
setlocal indentexpr=GetQmakeIndent(v:lnum)
setlocal indentkeys=0},!^F,o,O

if exists('*GetQmakeIndent')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

function GetQmakeIndent(lnum)
    let l:prev = prevnonblank(a:lnum - 1)
    if l:prev == 0
        return 0
    endif

    " line continuation
    if l:prev == a:lnum - 1 && s:has_linecont(l:prev)
        " increase indent after first continuation only
        return indent(l:prev) + (s:has_linecont(l:prev - 1) ? 0 : shiftwidth())
    endif

    " unhang indent
    let l:hang = l:prev
    while s:has_linecont(l:hang - 1)
        let l:hang -= 1
    endwhile
    let l:ind = indent(l:hang)

    " get previous line without comments
    let l:pline = getline(l:prev)
    let l:hash = stridx(l:pline, '#')
    if l:hash >= 0
        let l:pline = strpart(l:pline, 0, l:hash)
    endif

    " indent after opening brace
    if l:pline =~# '{\s*$'
        let l:ind += shiftwidth()
    endif

    " dedent upon closing brace
    if getline(a:lnum) =~# '^\s*}'
        let l:ind -= shiftwidth()
    endif

    return l:ind
endfunction

" Does a line end with odd number of backslashes?
function! s:has_linecont(lnum)
    let l:line = getline(a:lnum)
    return !empty(l:line) && stridx(l:line, '#') < 0 &&
        \ (strlen(l:line) - match(l:line, '\\*$')) % 2
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
