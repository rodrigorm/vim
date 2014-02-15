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

" Install jellybeans colorscheme
Bundle 'nanotech/jellybeans.vim'

" Install editorconfig support
Bundle 'editorconfig/editorconfig-vim'

" Install trailing spaces higlight
Bundle 'bronson/vim-trailing-whitespace'

" Install snipmate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

" Install vim-php-namespace
Bundle 'arnaud-lb/vim-php-namespace'

" Less syntax
Bundle 'groenewege/vim-less'

" Coffee scripts syntax
Bundle 'kchmck/vim-coffee-script'

colorscheme jellybeans " Pretty colors

syntax enable       " Enable syntax highlight
set encoding=utf-8
set showmode        " Show current input mode
set wildmenu        " Show vim menu with commands
set nu              " Show line numbers
set ai              " Enable auto tab/indent
set tabstop=4       " Tab using 4 spaces
set shiftwidth=4    " 4 spaces for (auto)indent
set softtabstop=4   " Use backspace for deindent
set expandtab       " Convert hard tab to spaces
set ruler           " Show cursor position
set cursorline      " Highlight current line
set laststatus=2    " Always show status bar
set showcmd         " Show typed command at statusbar
set hidden          " Remember undo after quitting
set showtabline=2 " always show tabs in gvim, but not vim

set autoread        " Automatic refresh changed files

set incsearch       " Enable incremental search
set hlsearch        " Enable search highlight
set ignorecase      " Case insensitive search
set smartcase       " If search contains uppercase enables case sensitive search

let mapleader=","   " Set <leader> to ,
set scrolloff=5     " When scrolling off-screen do so 3 lines at a time, not 1
set backspace=indent,eol,start " Make backspace work in insert mode

" Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Enable filetype detection
:filetype plugin on
:filetype plugin indent on

" Taglist Settings
nnoremap <leader>l :TlistToggle<CR>
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
    autocmd FileType * execute 'setlocal tags+=.git/tags/' . &filetype
    autocmd FileType * execute 'setlocal tags+=~/.ctags/' . &filetype . '/*/tags'
augroup END

set backupdir=/tmp/
set directory=/tmp/

" Disabled arrow key navigation
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>

" Tab navigation
nmap tn :tabnext<CR>
nmap tp :tabprevious<CR>

nnoremap <silent> <leader>nh :nohls <CR> " Hide search highlighting

" Map keys to vim-php-namespace
" <Leader>u Insert a use <CurrentClass> to header
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>

" <Leader>e to expand current class do complete namespace
inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

