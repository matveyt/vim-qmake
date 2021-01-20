" Vim syntax file
" Language:     qmake
" Maintainer:   matveyt
" Last Change:  2021 Jan 20
" License:      VIM License
" URL:          https://github.com/matveyt/vim-qmake

if exists('b:current_syntax')
    finish
endif
let b:current_syntax = 'qmake'

let s:save_cpo = &cpo
set cpo&vim

" Comments and Escapes
syn keyword qmakeTodo TODO FIXME XXX contained
syn match qmakeComment excludenl /#.*$/ contains=@Spell,qmakeTodo
    \ containedin=ALLBUT,qmakeComment
syn match qmakeEscape extend /\\$\|\\[[\]{}()$\\'"]/
    \ containedin=ALLBUT,qmakeComment,qmakeEscape

" Operators & RHS of assignment
syn match qmakeOperator /[!|:]/
syn match qmakeOperator /[-+*~]\?=/ nextgroup=qmakeRHS
syn region qmakeRHS start=/./ end=/$/ transparent contained
    \ contains=qmakeExpansion,qmakeQuotedString

" All expansions
syn match qmakeExpansion /\$\$\k\@=/ nextgroup=qmakeVariable,qmakeFunction
syn match qmakeExpansion /\$\${[^}]*}/ contains=qmakeVariable,qmakeFunction
syn match qmakeExpansion /\$\$\?([^)]*)/ contains=qmakeVariable
syn match qmakeExpansion /\$\$\[[^\]]*\]/ contains=qmakeVariable

" Quoted String
syn region qmakeQuotedString start=/\z(['"]\)/ end=/\z1/ end=/$/ contains=qmakeExpansion

" Variables, functions, scopes
" Note: qmakeVariable must precede qmakeFunction and qmakeScope to get lesser priority
syn match qmakeVariable /\<\k\+\>/
syn match qmakeFunction /\<\k\+(\@=/ nextgroup=qmakeArgs
syn region qmakeArgs excludenl start=/(/ end=/)/ end=/$/ contained
    \ contains=qmakeExpansion,qmakeQuotedString
syn match qmakeScope /[-+[:alnum:]*?[\]]\+\(\s*[|:{]\)\@=/

hi def link qmakeTodo Todo
hi def link qmakeComment Comment
hi def link qmakeEscape Special
hi def link qmakeOperator Operator
hi def link qmakeExpansion PreProc
hi def link qmakeQuotedString String
hi def link qmakeVariable Identifier
hi def link qmakeFunction Function
hi def link qmakeArgs NONE
hi def link qmakeScope PreCondit

let &cpo = s:save_cpo
unlet s:save_cpo
