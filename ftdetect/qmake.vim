autocmd BufNewFile,BufRead *.pr[oif]
    \   if !did_filetype() || &filetype is# 'idlang'
    \ |     setlocal filetype=qmake
    \ | endif
