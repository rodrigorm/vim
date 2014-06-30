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

" Install editorconfig support
Bundle 'editorconfig/editorconfig-vim'

" Install trailing spaces higlight
Bundle 'bronson/vim-trailing-whitespace'

" Less syntax
Bundle 'groenewege/vim-less'

" Coffee scripts syntax
Bundle 'kchmck/vim-coffee-script'

" Faster Ctrl-P Matcher
Bundle 'FelikZ/ctrlp-py-matcher'

" PHPQA Toolchain Integration
Bundle 'rodrigorm/vim-phpqa.git'
Bundle 'joonty/vim-phpunitqf.git'

" Vimscript test framework
Bundle 'junegunn/vader.vim'

syntax enable       " Enable syntax highlight
set encoding=utf-8
set showmode        " Show current input mode
set wildmenu        " Show vim menu with commands
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

set autoread        " Automatic refresh changed files

set incsearch       " Enable incremental search
set hlsearch        " Enable search highlight
set ignorecase      " Case insensitive search
set smartcase       " If search contains uppercase enables case sensitive search

let mapleader=","   " Set <leader> to ,
set scrolloff=5     " When scrolling off-screen do so 5 lines at a time, not 1
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

augroup TagFileType
    autocmd!
    autocmd FileType * execute 'setlocal tags+=.git/tags/' . &filetype
    autocmd FileType * execute 'setlocal tags+=~/.ctags/' . &filetype . '/*/tags'
augroup END

" Ignore some files for CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git
" Tells Ctrl_P to find files in current working directory
let g:ctrlp_working_path_mode = ''

" Enable Ctrl-P Py Matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Clear screen at exit
" autocmd VimLeave * :!clear

" Keyboard bindings
" Use ; instead of : at command mode, ;q or ;w instead of :q or :w
nnoremap ; :

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
nmap te :tabnew<CR>:edit<Space>
nmap to :tabnew<CR>
nmap tn :tabnext<CR>
nmap tp :tabprevious<CR>

" Location list navigation
nmap <leader>ln :lnext<CR>
nmap <leader>lp :lprevious<CR>

" Quick list navigation
nmap cn :cnext<CR>
nmap cp :cprevious<CR>

" Hide search highlighting
nnoremap <silent> <leader>/ :nohlsearch<CR>

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" File explorer
map <silent> <leader>t :Explore<CR>
map <silent> <leader>T :split +Explore<CR>

" Omni Complete using Ctrl-Space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

" Configure PHPQA using defaults from
" http://jenkins-php.org/
let g:phpqa_messdetector_ruleset="build/phpmd.xml"
let g:phpqa_codesniffer_args="--standard=build/phpcs.xml"
let g:phpqa_messdetector_autorun=1
let g:phpqa_codesniffer_autorun=1
let g:phpqa_codecoverage_autorun=1
let g:phpqa_codecoverage_file="build/logs/clover.xml"
let g:phpqa_codecoverage_showcovered=1

function! ComposerRoot()
    let path = expand('%:p')
    while path != fnamemodify(path, ':h')
        let path = fnamemodify(path, ':h')
        if filereadable(path . "/composer.json")
            return path
        endif
    endwhile
    return getcwd()
endfunction

function! ComposerBin(name)
    if filereadable(ComposerRoot() . "/vendor/bin/" . a:name)
        return ComposerRoot() . "/vendor/bin/" . a:name
    endif
    return a:name
endfunction

" Use from composer if exists
augroup PHPQA
    autocmd!
    autocmd FileType php let g:phpqa_codesniffer_cmd=ComposerBin("phpcs")
    autocmd FileType php let g:phpqa_messdetector_cmd=ComposerBin("phpmd")
    autocmd FileType php let g:phpunit_cmd=ComposerBin("phpunit")
    autocmd BufWritePost *.php call PhpTest()
augroup END

function! PhpTest()
    let l:test = PhpTestForFile(expand('%'))

    if filereadable(l:test)
        :Test
    endif
endfunction

" Let PHPUnitQf use the callback function
let g:phpunit_callback = "PHPTestCallback"

" Try to find the test file of current open file
function! PHPTestCallback(args)
    " Trim white space
    let l:args = substitute(a:args, '^\s*\(.\{-}\)\s*$', '\1', '')

    " If no arguments are passed to :Test
    if len(l:args) is 0
        let l:args = PhpTestForFile(expand('%'))
    endif

    return l:args
endfunction

function! PhpTestForFile(path)
    " Trim white space
    let l:file = substitute(a:path, '^\s*\(.\{-}\)\s*$', '\1', '')
    let l:test = ""

    " If no arguments are passed to :Test
    if l:file =~ "^src/.*"
        return substitute(l:file,'^src/\(.\{-}\)\.php$', 'tests/\1Test.php', '')
    endif

    return l:file
endfunction
