set shell=/bin/bash
"
"Encoding
set encoding=utf-8
scriptencoding utf-8

"View ------------------------------------------------
set number                       "行番号
set showmatch                    "括弧の対応をハイライト
set showcmd                      "入力中のコマンドを表示
set list lcs=tab:\|\ ,eol:↲      " 不可視文字表示
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P
set cursorline                   "カーソル行をハイライト
set splitbelow                   "新しいウインドウを下に開く
set splitright                   "新しいウインドウを右に開く

"Indent ----------------------------------------------
"" タブ設定
set expandtab                    "タブをスペースに変換
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent
set smartindent

"Search ---------------------------------------------
set wrapscan                     "最後まで検索したら最初に戻る
set ignorecase                   "大文字小文字無視
set smartcase                    "大文字ではじめたら大文字小文字無視しない

"Other ----------------------------------------------
set noswapfile                   " swapファイルを作成しない
"set clipboard=autoselect         " ビジュアルモードで選択したテキストが、クリップボードに入るようにする
set clipboard+=unnamed           " 無名レジスタに入るデータを、*レジスタにも入れる。
" linuxの場合必要
set clipboard=unnamedplus
set backspace=indent,eol,start
set tags+=~/.tags                " ctagsの設定

"au BufRead,BufNewFile *.md set filetype=markdown "ファイルタイプの設定
