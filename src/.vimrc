" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.vim/plugged')

" ---------------------- Plugins from github repos:

Plug 'sjl/vitality.vim'                     " Make Vim play nicely with iTerm 2 and tmux
Plug 'itchyny/lightline.vim'                " Configurable statusline/tabline
Plug 'scrooloose/nerdtree'                  " Better file browser
Plug 'jlanzarotta/bufexplorer'              " Quickly and easily switch between buffers
Plug 'jeffkreeftmeijer/vim-numbertoggle'    " Toggle line numbering absolute/relative
Plug 'easymotion/vim-easymotion'            " Vim motions on speed!
Plug 'editorconfig/editorconfig-vim'        " EditorConfig plugin for Vim
Plug 'tpope/vim-fugitive'                   " Git wrapper
Plug 'airblade/vim-gitgutter'               " Git diff in the gutter (sign column) and stages/undoes hunks
Plug 'kien/ctrlp.vim'                       " Fuzzy file, buffer, mru, tag, ...etc finder
Plug 'vim-syntastic/syntastic'              " Syntax checking hacks for vim
" Plug 'davidhalter/jedi-vim'                 " Awesome Python autocompletion with VIM
" Plug 'leafgarland/typescript-vim'           " Typescript syntax files for Vim
" Plug 'hashivim/vim-terraform'               " Basic vim/terraform integration
" Plug 'ianks/vim-tsx'                        " Syntax highlighting and indenting for .tsx files
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'junegunn/fzf', { 'do': './install --bin' }  " Required for fzf.vim (next plugin)
Plug 'junegunn/fzf.vim'                     " Fuzzy finding for VIM
Plug 'Xuyuanp/nerdtree-git-plugin'          " A plugin of NERDTree showing git status
Plug 'preservim/nerdcommenter'              " Vim plugin for intensely nerdy commenting powers
Plug 'ryanoasis/vim-devicons'               " Adds file type icons to Vim plugins
Plug 'sheerun/vim-polyglot'                 " A solid language pack for Vim
Plug 'daylerees/colour-schemes', { 'rtp': 'vim' }   " Colour schemes for a variety of editors created by Dayle Rees
Plug 'rainglow/vim'                         " 320+ color themes for VIM
if has('python')
    Plug 'pignacio/vim-yapf-format' " YAPF formatter for Python
endif

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings

" no vi-compatible
set nocompatible


" Set color scheme (and theme)
set t_Co=256		    " Enable 256 colors in vim
if (has('termguicolors'))
  set termguicolors
endif
" colorscheme pastel
colorscheme joker
let g:lightline = { 'colorscheme': 'powerline' }      " Other option os 'powerline'
set guifont=HackNerdFontComplete-Regular:h16
set linespace=3
syntax enable		" Set syntax highlighting ON

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" Change <Leader> (default is \)
let mapleader = ','

" Set relative numbering by default

" General settings
set ls=2                    " always show status bar
set autochdir               " The working directory is always the one where the active buffer is located.
set cursorline              " Highlight the current line
set enc=utf-8		    " Set UTF-8 encoding
set mousehide		    " Hide the mouse when typing
set nocompatible	    " be iMproved

" Indent settings
set autoindent		    " Same indent as previous line
set expandtab		    " Replace <Tab> by spaces
set shiftwidth=2	    " Spaces for the >> operation
set smartindent		    " Smart insertion of indent in some cases
set softtabstop=2	    " How many columns is a <Tab>
"set tabstop=4		    " Spaces inserted when pressing <Tab> key

" Search settings
set hlsearch		    " Highlight searching  
set incsearch		    " Incremental searching
set smartcase		    " Set smart case

" Disable arrow keys
" map         <Left>  <Nop>
" imap        <Left>  <Nop>
" map         <Right> <Nop>
" imap        <Right> <Nop>
" map         <Up>    <Nop>
" imap        <Up>    <Nop>
" map         <Down>  <Nop>
" imap        <Down>  <Nop>

" More natural split opening
set splitbelow
set splitright

" Navigate 4x faster when holding down Ctrl
nmap <c-j> 4j
nmap <c-k> 4k
nmap <c-h> 4h
nmap <c-l> 4l

" Navigate tabs
nmap <c-t> gt
nmap <c-T> gT

" Toggle highlighting
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" When scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" Store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" Create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" Exclude files and directories using Vim's wildignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

" ============================================================================
" Plugins settings and mappings

" CoC (Make your Vim/Neovim as smart as VSCode)
" Prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" NERDTree -----------------------------
nmap <c-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^node_modules$','^venv$','^.git$']

" vim-numbertoggle -----------------------------
set number relativenumber

" FZF
"map <C-;> :Files<CR>

" CtrlP -----------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|node_modules\|venv\|log\|tmp$',
  \ 'file': '\.DS_Store$'
  \ }

" Syntastic ------------------------------
nmap <leader>e :Errors<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
" custom icons (enable them if you use a patched font, and enable the previous 
" setting)
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" Jedi-vim ------------------------------
let g:jedi#goto_command = ',d'
let g:jedi#usages_command = ',o'

" NeoComplCache ------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_fuzzy_completion_start_length = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_manual_completion_start_length = 1
let g:neocomplcache_min_keyword_length = 1
let g:neocomplcache_min_syntax_length = 1
" complete with workds from any opened file
let g:neocomplcache_same_filetype_lists = {}
let g:neocomplcache_same_filetype_lists._ = '_'

" Fugitive ------------------------------
set statusline+=%{FugitiveStatusline()}

" Statusline ----------------------------
set statusline+=%*
