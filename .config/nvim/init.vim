set number
set noswapfile
set laststatus=2

inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC> 
inoremap <silent> <C-k> k

filetype indent on
set tabstop=2
set shiftwidth=2
set expandtab

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
    " 予め toml ファイルを用意しておく
    let g:rc_dir = expand("~/.config/nvim/")
    let s:toml = g:rc_dir . '/dein.toml'
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

