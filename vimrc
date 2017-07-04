set nocompatible

" Disable for vundle install
filetype off

" Enable vundle bundle manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Install bundles here

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

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

" PHP Syntax
Plugin 'StanAngeloff/php.vim'

" PHPQA Toolchain Integration
Plugin 'joonty/vim-phpqa'
Plugin 'joonty/vim-phpunitqf'
Plugin 'afternoon/vim-phpunit'
Plugin 'veloce/vim-behat'

" Vimscript test framework
Plugin 'junegunn/vader.vim'

" Projectionist
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-projectionist'

" PHPComplete
Plugin 'shawncplus/phpcomplete.vim'

" Taggatron
Plugin 'joonty/vim-taggatron'

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
" Plugin 'unblevable/quick-scope'

" PHP + HTML Indent Support
Plugin 'captbaritone/better-indent-support-for-php-with-html'
Plugin '2072/PHP-Indenting-for-VIm'

" Emblem
Plugin 'heartsentwined/vim-emblem'

" JSON
Plugin 'elzr/vim-json'

" Pairs of handy bracket mappings
Plugin 'tpope/vim-unimpaired'

" TypeScript support
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'Shougo/vimproc.vim'

" Syntastic
Plugin 'vim-syntastic/syntastic'

" Committia
Plugin 'rhysd/committia.vim'

" Enhanced netrw
Plugin 'tpope/vim-vinegar'

" JSON5 support
Plugin 'GutenYe/json5.vim'

" TOML support
Plugin 'cespare/vim-toml'

" GO Lang Support
Plugin 'fatih/vim-go'

call vundle#end()

syntax enable       " Enable syntax highlight
colorscheme default
if has("gui_macvim")
    set background=dark
endif

set encoding=utf-8
set showmode        " Show current input mode
set wildmenu        " Show vim menu with commands
set ai              " Enable auto tab/indent
set tabstop=4       " Hard tab using 4 spaces
set shiftwidth=4    " 4 spaces for (auto)indent
set ruler           " Show cursor position
set cursorline      " Enable highlight current line
set colorcolumn=120 " Color column 120
set laststatus=2    " Always show status bar
set noshowcmd       " Hide typed command at statusbar
set hidden          " Remember undo after quitting
set nobackup        " Disabled backup
set noswapfile      " Disable swp file
set relativenumber  " Show relative line numbers

set autoread        " Automatic refresh changed files

set incsearch       " Enable incremental search
set hlsearch        " Enable search highlight
set ignorecase      " Case insensitive search
set smartcase       " If search contains uppercase enables case sensitive search

let mapleader=','   " Set <leader> to ,
set scrolloff=5     " When scrolling off-screen do so 5 lines at a time, not 1
set backspace=indent,eol,start " Make backspace work in insert mode
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

" show invisible
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Automatic switch linenumber when in insert mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

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
" Go language
let tlist_go_settings = 'go;g:enum;s:struct;u:union;t:type;' .
                            \ 'v:variable;f:function'

augroup TagFileType
    autocmd!
    autocmd FileType * execute 'setlocal tags+=~/.ctags/' . &filetype . '/*/tags'
augroup END

let g:tagcommands = {
\   "php": {
\       "cmd": "phpctags",
\       "tagfile": ".git/php.tags",
\       "args": "--recurse"
\   },
\   "go": {
\       "cmd": "ctags",
\       "tagfile": ".git/go.tags",
\       "args": "-R",
\       "filesappend": "**/*.go"
\   }
\}

" Ignore some files for CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*/build/*

" Enable jsx highlighting in .js files
let g:jsx_ext_required = 0

" json settings
let g:vim_json_syntax_conceal = 0

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:go_autodetect_gopath = 1

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

" Quick save
nnoremap <silent> <Leader>w :update<CR>

" Tab navigation
nmap <Leader>te :tabnew<CR>:edit<Space>
nmap <Leader>to :tabnew<CR>
nmap <Tab> gt
nmap <S-Tab> gT

" Tag navigation
nmap ]g <C-]>
nmap [g <C-T>

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
let g:phpqa_messdetector_autorun=0
let g:phpqa_codesniffer_autorun=0
let g:phpqa_codecoverage_autorun=0
let g:phpqa_codecoverage_file='build/logs/clover.xml'
let g:phpqa_codecoverage_showcovered=0
let g:phpqa_open_loc=1
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

" Status Line: {{{

" Status Function: {{{2
function! Status(winnum)
    let active = a:winnum == winnr()
    let bufnum = winbufnr(a:winnum)

    let stat = ''

    " this handles alternative statuslines
    let usealt = 0
    let altstat = ' »'

    let type = getbufvar(bufnum, '&buftype')
    let name = bufname(bufnum)

    if type ==# 'help'
        let altstat .= ' ' . fnamemodify(name, ':t:r')
        let usealt = 1
    elseif name ==# '__Gundo__'
        let altstat .= ' Gundo'
        let usealt = 1
    elseif name ==# '__Gundo_Preview__'
        let altstat .= ' Gundo Preview'
        let usealt = 1
    endif

    if usealt
        let altstat .= ' «'
        return altstat
    endif

    let stat .= '%1*'
    let stat .= '%{Column()}'
    let stat .= '%*'

    " file name
    let stat .= active ? ' »' : ' «'
    let stat .= ' %<'
    let stat .= '%f'
    let stat .= ' ' . active ? '«' : '»'

    " file modified
    let modified = getbufvar(bufnum, '&modified')
    let stat .= modified ? ' +' : ''

    " read only
    let readonly = getbufvar(bufnum, '&readonly')
    let stat .= readonly ? ' ‼' : ''

    " paste
    if active && &paste
        let stat .= ' %2*' . 'P' . '%*'
    endif

    " right side
    let stat .= '%='

    " git branch
    if exists('*fugitive#head')
        let head = fugitive#head()

        if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
            call fugitive#detect(getcwd())
            let head = fugitive#head()
        endif
    endif

    if !empty(head)
        let stat .= ' ← ' . head . ' '
    endif

    return stat
endfunction

" column
"   this might seem a bit complicated but all it amounts to is
"   a calculation to see how much padding should be used for the
"   column number, so that it lines up nicely with the line numbers

"   an expression is needed because expressions are evaluated within
"   the context of the window for which the statusline is being prepared
"   this is crucial because the line and virtcol functions otherwise
"   operate on the currently focused window

function! Column()
    let vc = virtcol('.')
    let ruler_width = max([strlen(line('$')), (&numberwidth - 1)])
    let column_width = strlen(vc)
    let padding = ruler_width - column_width
    let column = ''

    if padding <= 0
        let column .= vc
    else
        " + 1 becuase for some reason vim eats one of the spaces
        let column .= repeat(' ', padding + 1) . vc
    endif

    return column . ' '
endfunction
" }}}

" Status AutoCMD: {{{
function! s:RefreshStatus()
    for nr in range(1, winnr('$'))
        call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
    endfor
endfunction

augroup status
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
augroup END
" }}}

" }}}

" CtrlP: {{{2

" Settings: {{{3
let g:ctrlp_map = '<leader>f'
let g:ctrlp_show_hidden = 1
" this is ignored since we're using ag
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]((\.(git|hg|svn))|build)$',
    \ 'file': '\v\.(DS_Store)$',
    \ }
let g:ctrlp_working_path_mode = 'ra'

if executable('ag')
    set grepprg=ag\ -nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor --ignore-dir .git -g ""'
    let g:ctrlp_use_caching = 0
endif

map <leader>b :CtrlPBuffer<cr>
" }}}

" StatusLine: {{{3
" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"            a:1    a:2      a:3       a:4  a:5   a:6  a:7
fu! CtrlP_main_status(...)
    let regex = a:3 ? '%2*regex %*' : ''
    let prv = '%#StatusLineNC# '.a:4.' %*'
    let item = ' ' . (a:5 == 'mru files' ? 'mru' : a:5) . ' '
    let nxt = '%#StatusLineNC# '.a:6.' %*'
    let byfname = '%2* '.a:2.' %*'
    let dir = '%3* ← %*%#StatusLineNC#' . fnamemodify(getcwd(), ':~') . '%* '

    " only outputs current mode
    retu ' %4*»%*' . item . '%4*«%* ' . '%=%<' . dir

    " outputs previous/next modes as well
    " retu prv . '%4*»%*' . item . '%4*«%*' . nxt . '%=%<' . dir
endf

" Argument: len
"           a:1
fu! CtrlP_progress_status(...)
    let len = '%#Function# '.a:1.' %*'
    let dir = ' %=%<%#LineNr# '.getcwd().' %*'
    retu len.dir
endf

hi CtrlP_Purple  ctermfg=255 ctermbg=54
hi CtrlP_IPurple ctermfg=54  ctermbg=255
hi CtrlP_Violet  ctermfg=54  ctermbg=104

let g:ctrlp_status_func = {
    \ 'main': 'CtrlP_main_status',
    \ 'prog': 'CtrlP_progress_status'
    \}
" }}}

" }}}
