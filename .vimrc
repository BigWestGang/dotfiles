set encoding=utf-8
scriptencoding utf-8

if !&compatible
  set nocompatible
endif

filetype indent on

" reset augroup
augroup vimrc
  autocmd!
augroup END

" dein本体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home.'/dein'
let s:dein_repo_dir = s:dein_dir.'/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim '.shellescape(s:dein_repo_dir))
endif

let &runtimepath = s:dein_repo_dir.','.&runtimepath

" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" Common Settings
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set cursorline
set number
set ruler
set laststatus=2
set backspace=2
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<
set hlsearch
set noshowcmd
let g:Tlist_WinWidth = 180

" BackSpace is God.
nnoremap <BS> <Left><Del>
nnoremap ^H <Left><Del>
inoremap <BS> <Left><Del>
inoremap ^H <Left><Del>

" Single LineMove
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp

" Multiple Line Move
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

" json viewer for jq
command -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg='.'
    else
        let l:arg=a:1
    endif
    execute "%! jq \"".l:arg."\""
endfunction