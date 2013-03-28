set nocompatible

" Disable for vundle install
filetype off

" Enable vundle bundle manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Install bundles here

" Install monokai colorscheme
Bundle 'sickill/vim-monokai'

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

set autoread        " Automatic refresh changed files

set incsearch       " Enable incremental search
set hlsearch        " Enable search highlight
set ignorecase      " Case insensitive search
set smartcase       " If search contains uppercase enables case sensitive search

colorscheme Monokai

" Enable filetype detection
:filetype plugin on
:filetype plugin indent on
