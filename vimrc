set nocompatible

" Disable for vundle install
filetype off

" Enable vundle bundle manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Install bundles here

" Show class and methods in file
Bundle 'vim-scripts/taglist.vim'

" Enable file navigate like Sublime (Ctrl+P) and Textmate (Cmd+T)
Bundle 'kien/ctrlp.vim'

" The best Git wrapper of all time
Bundle 'tpope/vim-fugitive'

" Gutter with diff changes
Bundle 'airblade/vim-gitgutter'

" Autoclose quotes and (
Bundle 'Townk/vim-autoclose'

" Install monokai colorscheme
Bundle 'sickill/vim-monokai'

" Install editorconfig support
Bundle 'editorconfig/editorconfig-vim'

syntax enable       " Enable syntax highlight
set encoding=utf-8
set showmode        " Show current input mode
set wildmenu        " Show vim menu with commands
set background=dark " Use dark background
set nu              " Show line numbers
set ai              " Enable auto tab/indent
set tabstop=4       " Tab using 4 spaces
set shiftwidth=4    " 4 spaces for (auto)indent
set softtabstop=4   " Use backspace for deindent
set expandtab       " Convert hard tab to spaces
set ruler           " Show cursor position
set cursorline      " Destaca a linha atual
set laststatus=2    " Always show status bar
set showcmd         " Show typed command at statusbar
set hidden          " Remenber undo after quitting

set autoread        " Automatic refresh changed files

set incsearch       " Enable incremental search
set hlsearch        " Enable search highlight
set ignorecase      " Case insensitive search
set smartcase       " If search contains uppercase enables case sensitive search

" Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" colorscheme Monokai

" Enable filetype detection
:filetype plugin on
:filetype plugin indent on


" Taglist Settings
nnoremap ,l :TlistToggle<CR>
let Tlist_Use_Right_Window=1        " Show taglist at right
let Tlist_GainFocus_On_ToggleOpen=1 " Focus taglist when open
let Tlist_File_Fold_Auto_Close=1    " Does not show tag from disabled buffers
let Tlist_Sort_Type="name"          " Sort tags by name
let Tlist_Close_On_Select=1         " Close taglist when select
" Does not show variables for PHP buffers
let tlist_php_settings='php;c:Classes;f:Functions'

" Ignore some files for CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git
" Tells Ctrl_P to find files in current working directory
let g:ctrlp_working_path_mode = ''

" Clear screen at exit
autocmd VimLeave * :!clear

" Keyboard bindings
" Use ; instead of : at command mode, ;q or ;w instead of :q or :w
nnoremap ; :

augroup TagFileType
    autocmd!
    autocmd FileType * execute 'setlocal tags+=~/.ctags/' . &filetype . '/*/tags'
augroup END
