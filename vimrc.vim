set nocompatible " Because filetype detection doesn't work well in compatible mode

filetype off                   " required!

if filereadable($HOME . '/vimfiles/vimrc.vim')
    set rtp+=~/vimfiles/bundle/vundle
    let path='~/vimfiles/bundle'
    call vundle#begin(path)
else
    set rtp+=~/.vim/bundle/vundle
    call vundle#begin()
endif

let g:phpcs_std_list="PSR1,PSR2"

" <plugins>
"Plugin 'joonty/vim-phpqa.git'
"Plugin 'shawncplus/phpcomplete.vim'
Plugin 'ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'tpope/vim-fugitive'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'gmarik/vundle'
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'brookhong/DBGPavim'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
"Plugin 'hallettj/jslint.vim'
Plugin 'stephpy/vim-php-cs-fixer'
"For linting JS
Plugin 'kana/vim-submode'
Plugin 'arnaud-lb/vim-php-namespace' "\u
Plugin 'evidens/vim-twig'
Plugin 'PeterRincker/vim-argumentative' ">, <, ], [,
Plugin 'AndrewRadev/splitjoin.vim' "gS gJ
"Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'AndrewRadev/gapply.vim'
Plugin 'amcsi/auto-pairs'
"Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-unimpaired' "]x, ]u, ]q (:cn), ]y (c esc) ]space (space below) ]n (git conflicts) ]f (next file in dir)
Plugin 'tpope/vim-obsession'
Plugin 'chriskempson/tomorrow-theme'
Plugin 'xsbeats/vim-blade'
Plugin 'dag/vim2hs'
Plugin 'ElmCast/elm-vim'
Plugin 'kana/vim-fakeclip'
Plugin 'itchyny/lightline.vim'
Plugin 'Matt-Deacalion/vim-systemd-syntax'

if has('python')
  Plugin 'joonty/vdebug.git'
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'scrooloose/syntastic'
endif

" Plugins to not run in gvim
if !has("gui_running")
  Plugin 'edkolev/tmuxline.vim'
endif
"Plugin 'lambdatoast/elm.vim'
"Plugin 'mtscout6/syntastic-local-eslint.vim'
" </plugin>

" All of your Plugins must be added before the following line
call vundle#end()

"execute pathogen#infect()
"syntax on
"call pathogen#infect()
filetype plugin indent on     " required

"""""""""""""
"  GENERIC  "
"""""""""""""
set noswapfile " Don't use Swap files!!
set guitablabel=%N/\ %t\ %M
set showcmd
set incsearch
set display=lastline
set tabstop=4 "columns a tab represents
set softtabstop=4 ""
set shiftwidth=4 "columns of space to move line with << and >>
set autoindent "keep tabs after newline
set expandtab "tabs to spaces
set smarttab
"set smartindent "automatically indent after if
set autoread
set nu "for line numbers - opposite is set nonumber"
set cryptmethod=blowfish2
if has("mouse")
	set mouse=a mousemodel=popup 
endif
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end
set keywordprg=pman "K command for manual
set backspace=indent,eol,start "needed for cygwin (windows)
set so=10 "do not show below last line
set sj=1 "how many lines to scroll
filetype plugin on
let s:pluginIndent=1
"let g:php_folding=0

let g:ctags_statusline=1
let g:ctags_path='/usr/bin/ctags'

"set foldmethod=syntax
set cinoptions+=J1
set noro
set guifont=Powerline\ Consolas:h9,\ courier_new:h9 "GVim font
if has('unix') && has('gui_running') "otherwise GVim on linux looks ugly
	set guifont=Courier\ New\ Bold\ 9 "GVim font
endif
set hlsearch
set hidden "Change buffers without warning even on unsaved changes
if has('unix') && !has('win32unix')
  set sh=bash\ --rcfile\ ~/.bashvimrc "shell to run
elseif has('win32') && executable('bash')
  set sh=bash
  set shellcmdflag=--login\ -c
  set shellxquote=\"
endif
"set sxq=\" "linux default, but recommended setting after forcing bash on windows
set ssl "expand paths to slashes
"setlocal sp=2>&1\|\ tee "piping :make to errorformat
"setlocal sp=2> "piping :make to errorformat

set cpo-=a " :read shouldn't set the alternate file
set cpo-=A " :write shouldn't set the alternate file
"set cpo+=I "Keep autoindent after move without writing

" Cool tab completion stuff
set wildmenu
"set wildmode=list:longest,full
set wildignore+=.git/**
set wildignore+=.vendor/**

set ignorecase "ignore case in searches
set smartcase "don't ignore case if search string has an upper case
" character, or \C is in the pattern

highlight MatchParen ctermbg=4

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

let g:powerline_loaded = 0
let g:phpcomplete_enhance_jump_to_definition = 0

" compatible, unicode or fancy
let g:Powerline_symbols = 'unicode'

set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

" aka. ffs
set fileformats=unix,dos,mac
" aka. ff
set fileformat=unix
set diffopt=filler,iwhite

set lazyredraw

"syntax sync minlines=256 "for slow ssh connections

" http://stackoverflow.com/questions/890802/how-do-i-disable-the-press-enter-or-type-command-to-continue-prompt-in-vim
set shortmess=aoOtI

" Don't run messdetector on save (default = 1)
let g:phpqa_messdetector_autorun = 0

" Don't run codesniffer on save (default = 1)
let g:phpqa_codesniffer_autorun = 0

" indent switch-cases (causes more harm than benefit unfortunately)
"let g:PHP_vintage_case_default_indent = 1

let g:php_cs_fixer_level = "psr2"

let g:pdv_template_dir = $HOME ."/vimfiles/bundle/pdv/templates_snip"

"let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['php']

" https://github.com/ElmCast/elm-vim
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:elm_syntastic_show_warnings = 1

"let g:syntastic_javascript_jsl_conf = $HOME ."/vimfiles/other/jsl.conf"
"let g:syntastic_javascript_jshint_conf = $HOME ."/vimfiles/other/jshint.conf.js"

let g:AutoPairsMapBS=0

let g:submode_timeout=0

" ]m -> mmmm (next method) MMMM (prev method)
call submode#enter_with('nextMethod', 'n', '', ']m', ']m') 
call submode#leave_with('nextMethod', 'n', '', '<Esc>') 
call submode#map('nextMethod', 'n', '', 'm', ']m') 
call submode#map('nextMethod', 'n', '', 'M', '[m') 

" [m -> mmmm (prev method) MMMM (next method)
call submode#enter_with('prevMethod', 'n', '', '[m', ']m') 
call submode#leave_with('prevMethod', 'n', '', '<Esc>') 
call submode#map('prevMethod', 'n', '', 'm', '[m') 
call submode#map('prevMethod', 'n', '', 'M', ']m') 

set nottimeout
set ttimeoutlen=0
set timeoutlen=1000

" The Platinum Searcher works great under windows
" https://github.com/monochromegane/the_platinum_searcher
if executable('pt')
    let g:ackprg='pt'
    set grepprg=pt\ --nocolor\ --nogroup
endif

if !exists("g:vdebug_options")
    let g:vdebug_options = {}
endif
let g:vdebug_options['path_maps'] = {'D:' : '/cygdrive/d', 'C:' : '/cygdrive/c'}
let g:vdebug_options["break_on_open"] = 0
let g:bracketed_paste_tmux_wrap = 0 " do not allow bracketed paste wrap for tmux

set encoding=utf-8

" Auto save session on leave, but only if there already is a session.
function! SaveSession()
  if v:this_session != ""
    echo "Auto-saving session."
    exe 'mksession! ' . '"' . v:this_session . '"'
  endif
endfunction
au VimLeave * :call SaveSession()

"""""""""""""
"  PREPARE   "
""""""""""""""
if s:pluginIndent == 1
	if &filetype == 'javascript'
        set tabstop=2 "columns a tab represents
        set softtabstop=2 ""
        set shiftwidth=2 "columns of space to move line with << and >>
        "filetype indent on "Turns on filetype detection, filetype plugins, and filetype indenting 
		"all of which add nice extra features to whatever language you're using
	endif
endif
au FileType javascript setlocal ai
"autocmd FileType javascript filetype indent off
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

" copy to windows clipboard
function! Putclip(type, ...) range
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@
    if a:type == 'n'
        silent exe a:firstline . "," . a:lastline . "y"
    elseif a:type == 'c'
        silent exe a:1 . "," . a:2 . "y"
    else
        silent exe "normal! `<" . a:type . "`>y"
    endif
    "call system('putclip', @@)
    "As of Cygwin 1.7.13, the /dev/clipboard device was added to provide
    "access to the native Windows clipboard. It provides the added benefit
    "of supporting utf-8 characters which putclip currently does not. Based
    "on a tip from John Beckett, use the following:
    call writefile(split(@@,"\n"), '/dev/clipboard')
    let &selection = sel_save
    let @@ = reg_save
endfunction

function! Getclip()
  let reg_save = @@
  "let @@ = system('getclip')
  "Much like Putclip(), using the /dev/clipboard device to access to the
  "native Windows clipboard for Cygwin 1.7.13 and above. It provides the
  "added benefit of supporting utf-8 characters which getclip currently does
  "not. Based again on a tip from John Beckett, use the following:
  let @@ = join(readfile('/dev/clipboard'), "\n")
  setlocal paste
  exe 'normal p'
  setlocal nopaste
  let @@ = reg_save
endfunction

function! MkTabs()
    vsp
    tabe
    vsp
    tabe
    vsp
    normal! 1gt
endfunction

function! Mks()
    let oldSsop = &l:ssop
    set ssop=blank,buffers,tabpages,sesdir
    mks!
    let &l:ssop = oldSsop
endfunction

function! SaveQuickFixList(fname) 
 let list = getqflist() 
 for i in range(len(list)) 
  if has_key(list[i], 'bufnr') 
   let list[i].filename = fnamemodify(bufname(list[i].bufnr), ':p') 
   unlet list[i].bufnr 
  endif 
 endfor 
 let string = string(list) 
 let lines = split(string, "\n") 
 call writefile(lines, a:fname) 
endfunction 

function! LoadQuickFixList(fname) 
 let lines = readfile(a:fname) 
 let string = join(lines, "\n") 
 call setqflist(eval(string)) 
endfunction 

""""""""""""""
"  MAPPING   "
""""""""""""""
inoremap <F2> <C-c>:call PhpDocSingle()<CR>i 
nnoremap <F2> :call PhpDocSingle()<CR> 
vnoremap <F2> :call PhpDocRange()<CR>

"keep visual selection after shifting tabs
vnoremap > >gv
vnoremap < <gv

map <Leader><CR> DO<C-c>p

function! RmSwp()
    !rm %:h/.%:t.swp
endfunction

command! RmSwp :!rm %:h/.%:t.swp

" Have 3 tabs with 2 verticle splits each
command! MkTabs call MkTabs()

" Make a lightweight Session.vim
command! Mks call Mks()

" Visual Block command in case C-V doesn't work on a terminal.
command! Vb normal! <C-v>

nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
"imap <F4> <C-c><F4>
"nmap <F4> :!js /home/amcsi/bin/js/runjslint.js "`cat %`" \| /home/amcsi/bin/python/format_lint_output.py<CR>

"yank, but keep position
vnoremap gy ygv<C-c>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
" amcsi: this is bad, because it keeps the BOTTOM reached message
"map N Nzz
"map n nzz

"Sorry, the '.' is bothersome on the Hungarian keyboard
map . <Nop>

" On some terminals, shift-tab isn't recognized properly. This is the remedy.
" If it messes it up, remove this.
exe 'set t_kB=' . nr2char(27) . '[Z'

" mintty Ctrl-6
nnoremap <C-_> <C-^>
vnoremap <C-_> <C-^>
inoremap <C-_> <C-^>

" copy to windows clipboard
vnoremap <silent> <leader>y :call Putclip(visualmode(), 1)<CR>
nnoremap <silent> <leader>y :call Putclip('n', 1)<CR>
" paste from windows clipboard
nnoremap <silent> <leader>p :call Getclip()<CR>

" Remap normal Ex-mode with 'apply last macro'
" Use gQ instead for Ex-mode; it's a better Ex-mode anyway with wildmode
nnoremap Q @@

let maplocalleader = ','

" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping 
function! NoremapNormalCmd(key, preserve_omni, ...)
  let cmd = ''
  let icmd = ''
  for x in a:000
    let cmd .= x
    let icmd .= "<C-\\><C-O>" . x
  endfor
  execute ":nnoremap <silent> " . a:key . " " . cmd
  execute ":vnoremap <silent> " . a:key . " " . cmd
  if a:preserve_omni
    execute ":inoremap <silent> <expr> " . a:key . " pumvisible() ? \"" . a:key . "\" : \"" . icmd . "\""
  else
    execute ":inoremap <silent> " . a:key . " " . icmd
  endif
endfunction

" Fix keycodes (PhpStorm)
map <Esc>[H <Home>
map <Esc>[F <End>
map <Esc>[A <Up>
map <Esc>[B <Down>
map <Esc>[C <Right>
map <Esc>[D <Left>
imap <Esc>[H <Home>
imap <Esc>[F <End>
imap <Esc>[A <Up>
imap <Esc>[B <Down>
imap <Esc>[C <Right>
imap <Esc>[D <Left>
cmap <Esc>[H <Home>
cmap <Esc>[F <End>
cmap <Esc>[A <Up>
cmap <Esc>[B <Down>
cmap <Esc>[C <Right>
cmap <Esc>[D <Left>

" Cursor moves by screen lines
call NoremapNormalCmd("<Up>", 1, "gk")
call NoremapNormalCmd("<Down>", 1, "gj")
call NoremapNormalCmd("<Home>", 0, "g<Home>")
call NoremapNormalCmd("<End>", 0, "g<End>")

" PageUp/PageDown preserve relative cursor position
call NoremapNormalCmd("<PageUp>", 0, "<C-U>", "<C-U>")
call NoremapNormalCmd("<PageDown>", 0, "<C-D>", "<C-D>")

nmap ú <C-]>
autocmd FileType php nnoremap <buffer> ú :<C-u>call phpcomplete#JumpToDefinition('normal')<CR>
autocmd FileType php nnoremap <buffer> <F12> :<C-u>call phpcomplete#JumpToDefinition('split')<CR>

"let g:UltiSnipsExpandTrigger       = '<F5>'


""""""""""""""
" FUNCTIONS  "
""""""""""""""
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

""""""""""""""
"   SCREEN   "
""""""""""""""
let g:isScreen=$SCREEN
if g:isScreen != ''
    exe "set title titlestring=%t"
    exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
    function! ResetTitle()
        " disable vim's ability to set the title
        exec "set title t_ts='' t_fs=''"

        " and restore it to 'bash'
        exec ":!echo -e '\033kb\033\\'\<CR>"
    endfunction
    au VimLeave * silent call ResetTitle()
endif

" This should solve junk appearing in windows prompt
" http://vi.stackexchange.com/a/3642
if exists(&restorescreen)
    if has("win32")
        set restorescreen
    else
        set norestorescreen
    endif
elseif !has("win32")
    set t_ti=
    set t_te=
endif

if has("win32unix")
    " mode dependent cursor (mintty)
    let &t_ti.="\eP\e[1 q\e\\"
    let &t_te.="\eP\e[0 q\e\\"

    let &t_SI.="\eP\e[5 q\e\\"
    let &t_EI.="\eP\e[1 q\e\\"
endif


"Speed up vsplit scrolling
"if &term =~ "xterm"
"    let &t_ti .= "\e[?6h\e[?69h"
"    let &t_te .= "\e7\e[?69l\e[?6l\e8"
"    let &t_CV = "\e[%i%p1%d;%p2%ds"
"    let &t_CS = "y"
"endif

" supposedly this will make va' and va" not include whitespace
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '"', "'" ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

""""""""""""""
"  LANGUAGE  "
""""""""""""""
"setlocal shellpipe=2>
"setlocal shellpipe="2>&1| tee"

autocmd FileType php,html setlocal makeprg=php\ -l\ '%'
autocmd FileType php,html setlocal errorformat=%m\ in\ %f\ on\ line\ %l
if !has('unix') || has('win32unix')
	"autocmd FileType php setlocal makeprg=C:\\Windows\\PHP\\php.exe
	"autocmd FileType html setlocal makeprg=C:\\Windows\\PHP\\php.exe
endif

"set makeprg=php\ -l\ %\ 2>&1
"set makeprg=php\ -l\ %\ 3>&1\ 1>&2\ 2>&3\ 3>&- "theoretically swaps stderr and stdout
"set makeprg=php\ -l\ %\ 2>&1\ >\ /dev/null
"set makeprg=php\ -l\ %\ 2>&1\ 2>\ /dev/null
au BufRead,BufNewFile *.tpl setlocal filetype=smarty 
au BufRead,BufNewFile *.json setlocal filetype=javascript
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete

au FileType javascript setlocal expandtab

"if filereadable("Main.elm")
"  au BufWritePost *.elm ElmMakeFile("Main.elm")
"elseif filereadable("app/Main.elm")
"  au BufWritePost *.elm ElmMakeFile("app/Main.elm")
"endif

if !has('unix')
  let g:elm_format_autosave = 1
else
  let g:elm_format_autosave = 0
endif

" https://github.com/ElmCast/elm-vim
let g:ycm_semantic_triggers = {
     \ 'elm' : ['.'],
     \}

" http://stackoverflow.com/a/774599/1381550
" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

""""""""""""""
"  BUFFERS   "
""""""""""""""

""""""""""""""
"    INFO    "
""""""""""""""
"Find ~/.vim directories: :echo &rtp

""""""""""""""
"   XDEBUG   "
""""""""""""""

""""""""""""""
"  SKINNING  "
""""""""""""""
let g:CSApprox_verbose_level=0
syntax enable

hi WildMenu cterm=NONE,bold ctermbg=Black ctermfg=Green gui=NONE,bold guibg=green guifg=black

"set bg=dark
"let xterm16_brightness = 'default'     " Change if needed 
let xterm16_colormap = 'standard'       " Change if needed 
if has('gui_running')
	color ir_black
elseif $TERM=~'16color' || $TERM == 'dumb' || $TERM == 'msys' || $TERM == 'cygwin' || $TERM == ''
	set t_Co=16
	color xterm16
else
	set t_Co=256
	color ir_black256
endif

if exists('$TMUX')
    autocmd BufEnter,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
    au VimLeave * silent call system("tmux rename-window b")
endif

"let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

function! ChangeGuideColor()
    if 'ir_black256' == g:colors_name
        hi IndentGuidesEven ctermbg=235
        hi IndentGuidesOdd ctermbg=233
        "hi IndentGuidesEven ctermbg=240
        "hi IndentGuidesOdd ctermbg=236
    else
        hi IndentGuidesEven ctermbg=235
        hi IndentGuidesOdd ctermbg=233
    endif
endfunction

if !has('gui_running')
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme * call ChangeGuideColor()
endif

""""""""""""""
"  AUTOCMD   "
""""""""""""""
autocmd VimResized * wincmd =

" Pipe to mysql: :'<,'>w !mysql

" q: -> Edit command in small window

"inoremap <silent><tab> <c-r>=CleverTab#Complete('start')<cr>
"                      \<c-r>=CleverTab#Complete('tab')<cr>
"                      \<c-r>=CleverTab#Complete('ultisnips')<cr>
"                      \<c-r>=CleverTab#Complete('stop')<cr>
"inoremap <silent><s-tab> <c-r>=CleverTab#Complete('prev')<cr>
                      "\<c-r>=CleverTab#Complete('keyword')<cr>
                      "\<c-r>=CleverTab#Complete('neocomplete')<cr>
                      "\<c-r>=CleverTab#Complete('omni')<cr>
