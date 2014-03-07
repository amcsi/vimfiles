set nocompatible " Because filetype detection doesn't work well in compatible mode

filetype off                   " required!
set rtp+=~/.vim/bundle/vundle

let g:phpcs_std_list="PSR1,PSR2"
call vundle#rc()

" <bundles>
"Bundle 'joonty/vim-phpqa.git'
"Bundle 'joonty/vdebug.git'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-bracketed-paste'
Bundle 'vim-fugitive'
"Bundle 'vim-indent-guides'
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-easymotion'
"Bundle 'brookhong/DBGPavim'
" </bundles>


"execute pathogen#infect()
"syntax on
"call pathogen#infect()
filetype plugin indent on     " required

"""""""""""""
"  GENERIC  "
"""""""""""""
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
set nu "for line numbers - opposite is set nonumber"
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
set so=5 "do not show below last line
set sj=1 "how many lines to scroll
filetype plugin on
let s:pluginIndent=1
"let g:php_folding=0

let g:ctags_statusline=1
let g:ctags_path='/usr/bin/ctags'

"set foldmethod=syntax
set cinoptions+=J1
set noro
set guifont=courier_new:h9 "GVim font
if has('unix') && has('gui_running') "otherwise GVim on linux looks ugly
	set guifont=Courier\ New\ Bold\ 9 "GVim font
endif
set hlsearch
set hidden "Change buffers without warning even on unsaved changes
set sh=bash\ --rcfile\ ~/.bashvimrc "shell to run
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

set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

set ffs=unix,dos
set ff=unix
set diffopt=filler,iwhite

" Do not show ATTENTION message
"set shortmess+=A

" Don't run messdetector on save (default = 1)
let g:phpqa_messdetector_autorun = 0

" Don't run codesniffer on save (default = 1)
let g:phpqa_codesniffer_autorun = 0

""""""""""""""
"  PREPARE   "
""""""""""""""
if s:pluginIndent == 1
	"if &filetype != 'javascript'
		filetype indent on "Turns on filetype detection, filetype plugins, and filetype indenting 
		"all of which add nice extra features to whatever language you're using
	"endif
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

""""""""""""""
"  MAPPING   "
""""""""""""""
inoremap <F2> <C-c>:call PhpDocSingle()<CR>i 
nnoremap <F2> :call PhpDocSingle()<CR> 
vnoremap <F2> :call PhpDocRange()<CR>
inoremap ( ()<left>
inoremap (( (
inoremap () ()
inoremap [ []<left>
inoremap [[ [
inoremap [] []
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<C-c>O
"autocmd FileType javascript inoremap {<CR>  {<CR>}<C-c>O
inoremap {{     {
inoremap {}     {}

"keep visual selection after shifting tabs
vnoremap > >gv
vnoremap < <gv

map <Leader><CR> DO<C-c>p

function! RmSwp()
    !rm %:h/.%:t.swp
endfunction

command! RmSwp :!rm %:h/.%:t.swp
"map <F5> :Vexplore<CR>
"imap <F5> <C-c>:Vexplore<CR>

nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
"imap <F4> <C-c><F4>
"nmap <F4> :!js /home/amcsi/bin/js/runjslint.js "`cat %`" \| /home/amcsi/bin/python/format_lint_output.py<CR>

"yank, but keep position
vnoremap gy ygv<C-c>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

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

" Cursor moves by screen lines
call NoremapNormalCmd("<Up>", 1, "gk")
call NoremapNormalCmd("<Down>", 1, "gj")
call NoremapNormalCmd("<Home>", 0, "g<Home>")
call NoremapNormalCmd("<End>", 0, "g<End>")

" PageUp/PageDown preserve relative cursor position
call NoremapNormalCmd("<PageUp>", 0, "<C-U>", "<C-U>")
call NoremapNormalCmd("<PageDown>", 0, "<C-D>", "<C-D>")

""""""""""""""
" FUNCTIONS  "
""""""""""""""
function s:MkNonExDir(file, buf)
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
exe "set title titlestring=%t"
exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
function! ResetTitle()
    " disable vim's ability to set the title
    exec "set title t_ts='' t_fs=''"

    " and restore it to 'bash'
    exec ":!echo -e '\033kb\033\\'\<CR>"
endfunction
au VimLeave * silent call ResetTitle()
set t_ti=
set t_te=

" mode dependent cursor (mintty)
let &t_ti.="\eP\e[1 q\e\\"
let &t_te.="\eP\e[0 q\e\\"

let &t_SI.="\eP\e[5 q\e\\"
let &t_EI.="\eP\e[1 q\e\\"


"Speed up vsplit scrolling
if &term =~ "xterm"
    let &t_ti .= "\e[?6h\e[?69h"
    let &t_te .= "\e7\e[?69l\e[?6l\e8"
    let &t_CV = "\e[%i%p1%d;%p2%ds"
    let &t_CS = "y"
endif

" Supposed support for Bracketed Paste mode
if &term =~ "screen"
    let &t_SI .= "\eP\e[3 q\e\\"
    let &t_EI .= "\eP\e[1 q\e\\"
else
    let &t_SI .= "\e[3 q"
    let &t_EI .= "\e[1 q"
endif


""""""""""""""
"  LANGUAGE  "
""""""""""""""
"setlocal shellpipe=2>
"setlocal shellpipe="2>&1| tee"

autocmd FileType php,html setlocal makeprg=php\ -l\ '%'
if !has('unix') || has('win32unix')
	"autocmd FileType php setlocal makeprg=C:\\Windows\\PHP\\php.exe
	"autocmd FileType html setlocal makeprg=C:\\Windows\\PHP\\php.exe
endif

"set makeprg=php\ -l\ %\ 2>&1
"set makeprg=php\ -l\ %\ 3>&1\ 1>&2\ 2>&3\ 3>&- "theoretically swaps stderr and stdout
"set makeprg=php\ -l\ %\ 2>&1\ >\ /dev/null
"set makeprg=php\ -l\ %\ 2>&1\ 2>\ /dev/null
set errorformat=%m\ in\ %f\ on\ line\ %l
au BufRead,BufNewFile *.tpl setlocal filetype=smarty 
au BufRead,BufNewFile *.json setlocal filetype=javascript
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete

au FileType javascript setlocal expandtab

augroup CommaError 
au!
" clear matches on most file types 
autocmd Filetype * match 
" match commas on end of line for javascript 
autocmd Filetype javascript match Error /,\_s*[)}\]]/ 
augroup END

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
elseif $TERM=~'16color' || $TERM == 'dumb'
	set t_Co=16
	color xterm16
else
	set t_Co=256
	color ir_black256
endif

""""""""""""""""""""""""""
"  TMUX BRACKETED PASTE  "
""""""""""""""""""""""""""
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

if exists('$TMUX')
    "autocmd BufEnter,BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
    autocmd FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
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