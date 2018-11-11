:set relativenumber number " Set relative numbers for lines

" Force not use of arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

:syntax on " Enable syntax highlighting

" Define default tabs for coding
:set tabstop=2
:set shiftwidth=2
:set expandtab

" Override tabs for some programming languages
autocmd Filetype go setlocal tabstop=4 shiftwidth=4

