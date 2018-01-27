inoremap <C-c> <Esc>
noremap <S-h> ^
noremap <S-l> $
noremap <Esc><Esc> :noh<CR>

inoremap { {}<Left>
inoremap ( ()<Left>

set number
set noswapfile
set laststatus=2


filetype indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set expandtab

" move map
noremap <silent> j gj
noremap <silent> k gk
inoremap <silent> <C-j> <Down>
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-l> <Right>
noremap <silent> <C-j> <C-d>
noremap <silent> <C-k> <C-u>

if has('nvim')
  nnoremap @t :tabe<CR>:terminal<CR>
  tnoremap <C-q> <C-\><C-n>:q<CR>
  tnoremap <ESC> <C-\><C-n>
  tnoremap <C-l> <C-\><C-n>gt
  tnoremap <C-h> <C-\><C-n>gT
endif

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " プラグインリストを収めた toml ファイル
    let g:rc_dir = expand("~/.config/nvim/")
    let s:toml = g:rc_dir . 'dein.toml'
    let s:lazy_toml = g:rc_dir . 'dein_lazy.toml'

    " toml を読み込み、キャッシュしておく
    call dein#load_toml(s:toml,{'lazy':0})
    call dein#load_toml(s:lazy_toml,{'lazy':1})

    " 設定終了
    call dein#end()
    call dein#save_state()
endif

" もし、未インストールのものがあったらインストール
if dein#check_install()
    call dein#install()
endif
