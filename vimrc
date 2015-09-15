set nocompatible

" Disable for vundle install
filetype off

" Enable vundle bundle manager
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Install bundles here

" Show class and methods in file
Plugin 'vim-scripts/taglist.vim'

" Enable file navigate like Sublime (Ctrl+P) and Textmate (Cmd+T)
Plugin 'kien/ctrlp.vim'

" The best Git wrapper of all time
Plugin 'tpope/vim-fugitive'

" Install editorconfig support
Plugin 'editorconfig/editorconfig-vim'

" Install trailing spaces higlight
Plugin 'bronson/vim-trailing-whitespace'

" Less syntax
Plugin 'groenewege/vim-less'

" Coffee scripts syntax
Plugin 'kchmck/vim-coffee-script'

" Faster Ctrl-P Matcher
Plugin 'FelikZ/ctrlp-py-matcher'

" PHPQA Toolchain Integration
Plugin 'rodrigorm/vim-phpqa'
Plugin 'joonty/vim-phpunitqf'
Plugin 'afternoon/vim-phpunit'
Plugin 'veloce/vim-behat'

" Vimscript test framework
Plugin 'junegunn/vader.vim'

" Projectionist
Plugin 'rodrigorm/vim-dispatch'
Plugin 'tpope/vim-projectionist'

" CakePHP
Plugin 'violetyk/cake.vim'

" PHPComplete
Plugin 'shawncplus/phpcomplete.vim'

" Taggatron
Plugin 'rodrigorm/vim-taggatron'

" DBGP Debugger client
Plugin 'joonty/vdebug'

" Supertab
Plugin 'ervandew/supertab'

" Rust Language
Plugin 'rust-lang/rust.vim'

" JSX Language
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" Quick Scope Navigation
Plugin 'unblevable/quick-scope'

" PHP + HTML Indent Support
Plugin 'captbaritone/better-indent-support-for-php-with-html'

" Solarized
Plugin 'altercation/vim-colors-solarized'

call vundle#end()

syntax enable       " Enable syntax highlight
set background=dark
colorscheme solarized

set encoding=utf-8
set showmode        " Show current input mode
set wildmenu        " Show vim menu with commands
set ai              " Enable auto tab/indent
set tabstop=4       " Hard tab using 4 spaces
set shiftwidth=4    " 4 spaces for (auto)indent
set ruler           " Show cursor position
set cursorline    " Disable highlight current line
set laststatus=2    " Always show status bar
set noshowcmd       " Hide typed command at statusbar
set hidden          " Remember undo after quitting
set nobackup        " Disabled backup
set noswapfile      " Disable swp file

set autoread        " Automatic refresh changed files

set incsearch       " Enable incremental search
set hlsearch        " Enable search highlight
set ignorecase      " Case insensitive search
set smartcase       " If search contains uppercase enables case sensitive search

let mapleader=','   " Set <leader> to ,
set scrolloff=5     " When scrolling off-screen do so 5 lines at a time, not 1
set backspace=indent,eol,start " Make backspace work in insert mode

" Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Enable filetype detection
filetype plugin on
filetype plugin indent on

" Taglist Settings
nnoremap <leader>l :TlistToggle<CR>
let Tlist_Use_Right_Window=1        " Show taglist at right
let Tlist_GainFocus_On_ToggleOpen=1 " Focus taglist when open
let Tlist_File_Fold_Auto_Close=1    " Does not show tag from disabled buffers
let Tlist_Sort_Type='name'          " Sort tags by name
let Tlist_Close_On_Select=1         " Close taglist when select
" Does not show variables for PHP buffers
let tlist_php_settings='php;c:Classes;f:Functions'

augroup TagFileType
    autocmd!
    autocmd FileType * execute 'setlocal tags+=~/.ctags/' . &filetype . '/*/tags'
augroup END

let g:tagcommands = {
\   "php": {
\       "tagfile": ".git/php.tags",
\       "args": "--recurse --exclude=@.ctagsignore"
\   }
\}

" Ignore some files for CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*/build/*
" Tells Ctrl_P to find files in current working directory
let g:ctrlp_working_path_mode = ''

" Enable Ctrl-P Py Matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Enable jsx highlighting in .js files
let g:jsx_ext_required = 0

" Keyboard bindings
" Use ; instead of : at command mode, ;q or ;w instead of :q or :w
nnoremap ; :

" Disabled arrow key navigation
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>

" Go down/up by screen line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Use jj to go back to normal mode,
inoremap jj <ESC>

" Tab navigation
nmap <Leader>te :tabnew<CR>:edit<Space>
nmap <Leader>to :tabnew<CR>
nmap <Tab> gt
nmap <S-Tab> gT

" Location list navigation
nmap <leader>on :lnext<CR>
nmap <leader>op :lprevious<CR>

" Quick list navigation
nmap <leader>cn :cnext<CR>
nmap <leader>cp :cprevious<CR>

" Hide search highlighting
nnoremap <silent> <leader>/ :nohlsearch<CR>

set grepprg=grep\ -n\ --exclude-dir=build\ $*\ /dev/null
" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :grep! '\b<C-R><C-W>\b'<CR>:cw<CR>

" File explorer
map <silent> <leader>t :Explore<CR>
map <silent> <leader>T :split +Explore<CR>

" Omni Complete using Ctrl-Space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Map the leader key + q to toggle quick-scope's highlighting in normal/visual
" mode.
" Note that you must use nmap/vmap instead of their non-recursive versions
" (nnoremap/vnoremap).
nmap <leader>q <plug>(QuickScopeToggle)
vmap <leader>q <plug>(QuickScopeToggle)

" Configure PHPQA using defaults from
" http://jenkins-php.org/
let g:phpqa_messdetector_ruleset='build/phpmd.xml'
let g:phpqa_codesniffer_args='--standard=build/phpcs.xml'
let g:phpqa_messdetector_autorun=1
let g:phpqa_codesniffer_autorun=1
let g:phpqa_codecoverage_autorun=1
let g:phpqa_codecoverage_file='build/logs/clover.xml'
let g:phpqa_codecoverage_showcovered=0
let g:phpqa_open_loc=0
let g:feature_filetype='behat'
let g:behat_executables=['vendor/bin/behat']

function! RecursiveLocate(names, default)
    let path = expand('%:p')
    while path != fnamemodify(path, ':h')
        let path = fnamemodify(path, ':h')
        for name in a:names
            if filereadable(path . '/' . name)
                return path . '/' . name
            endif
        endfor
    endwhile

    return a:default
endfunction

function! ComposerBin(name)
    return RecursiveLocate(['vendor/bin/' . a:name, 'bin/' . a:name], a:name)
endfunction

function! ComposerSetup()
    let g:phpqa_codesniffer_cmd=ComposerBin('phpcs')
    let g:phpqa_codesniffer_args='--standard=' . RecursiveLocate(['build/phpcs.xml', 'phpcs.xml', 'vendor/rodrigorm/phpqa-make/phpcs.xml'], 'build/phpcs.xml')
    let g:phpqa_messdetector_cmd=ComposerBin('phpmd')
    let g:phpqa_messdetector_ruleset=RecursiveLocate(['build/phpmd.xml', 'phpmd.xml', 'vendor/rodrigorm/phpqa-make/phpmd.xml'], 'build/phpmd.xml')
    let g:phpunit_cmd=ComposerBin('phpunit')
    let &l:makeprg=ComposerBin('phpunit') . ' -c ' . RecursiveLocate(['tests/phpunit.xml', 'phpunit.xml', 'phpunit.xml.dist'], 'phpunit.xml.dist') . ' $*'
endfunction

" Use from composer if exists
augroup PHPQA
    autocmd!
    autocmd FileType php call ComposerSetup()
augroup END

function! PhpTest()
    let l:test = PhpTestForFile(expand('%'))

    if filereadable(l:test)
        :execute ':Test ' . l:test
    endif
endfunction

function! PhpTestForFile(path)
    " Trim white space
    let l:file = substitute(a:path, '^\s*\(.\{-}\)\s*$', '\1', '')
    let l:test = ''

    " If no arguments are passed to :Test
    if l:file =~ '^src/.*'
        return substitute(l:file,'^src/\(.\{-}\)\.php$', 'tests/\1Test.php', '')
    endif

    if l:file =~ '^tests/.*Test\.php'
        return l:file
    endif

    return ''
endfunction
