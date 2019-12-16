set nocompatible

" Disable for vundle install
filetype off

" Enable vundle bundle manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Install bundles here

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" sensible.vim: Defaults everyone can agree on
Plugin 'tpope/vim-sensible'

" Show class and methods in file
Plugin 'vim-scripts/taglist.vim'

" The best Git wrapper of all time
Plugin 'tpope/vim-fugitive'

" Install editorconfig support
Plugin 'editorconfig/editorconfig-vim'

" Install trailing spaces higlight
Plugin 'bronson/vim-trailing-whitespace'

" Vimscript test framework
Plugin 'junegunn/vader.vim'

" Projectionist
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-projectionist'

" DBGP Debugger client
Plugin 'joonty/vdebug'

" Supertab
Plugin 'ervandew/supertab'

" Pairs of handy bracket mappings
Plugin 'tpope/vim-unimpaired'

" Make your Vim a TypeScript IDE
Plugin 'Quramy/tsuquyomi'

" Syntastic
Plugin 'vim-syntastic/syntastic'

" Committia
Plugin 'rhysd/committia.vim'

" Enhanced netrw
Plugin 'tpope/vim-vinegar'

" Additional language syntax support
Plugin 'kchmck/vim-coffee-script' " Coffee scripts syntax
Plugin 'pangloss/vim-javascript' " improves javascfript
Plugin 'MaxMEllon/vim-jsx-pretty' " JSX syntax
Plugin 'jparise/vim-graphql' " GraphQL files and tags syntax
Plugin 'heartsentwined/vim-emblem' " Emblem
Plugin 'captbaritone/better-indent-support-for-php-with-html' " PHP + HTML Indent Support
Plugin '2072/PHP-Indenting-for-VIm' " PHP + HTML Indent Support
Plugin 'cespare/vim-toml' " TOML support

call vundle#end()

colorscheme default
if has("gui_macvim")
    set background=dark
endif

set showmode        " Show current input mode
set tabstop=4       " Hard tab using 4 spaces
set shiftwidth=4    " 4 spaces for (auto)indent
set noshowcmd       " Hide typed command at statusbar
set nobackup        " Disabled backup
set noswapfile      " Disable swp file
set number          " Show line number
set relativenumber  " Show relative line numbers

set hlsearch        " Enable search highlight
set ignorecase      " Case insensitive search
set smartcase       " If search contains uppercase enables case sensitive search

set scrolloff=5     " When scrolling off-screen do so 5 lines at a time, not 1
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

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

" Ignore some files
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
let g:syntastic_javascript_checkers = ['eslint']

let g:go_autodetect_gopath = 1

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

set grepprg=grep\ -n\ --exclude-dir=build\ --exclude-dir=.git\ --exclude-dir=mode_modules\ --exclude-dir=vendor\ $*\ /dev/null

" File explorer
map <silent> <leader>t :Explore<CR>
map <silent> <leader>T :split +Explore<CR>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

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
    let head = ''

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

au BufNewFile,BufRead *.ejs set filetype=html
