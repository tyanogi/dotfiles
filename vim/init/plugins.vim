"Pacage Control --------------------------------------
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
"-----------------------------------------------------

call dein#add('Shougo/vimshell.vim')
call dein#add('Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ })
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/unite.vim')              "ファイル表示
call dein#add('Shougo/neomru.vim')             "Unite.vimで最近使ったファイルを表示>できるようにする
call dein#add('scrooloose/nerdtree')           "ツリー型でファイルを表示 
call dein#add('Xuyuanp/nerdtree-git-plugin')   "ファイルの変更を表示 nerdtree
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('itchyny/lightline.vim')         "ステータスライン
call dein#add('Yggdroot/indentLine')           "インデント
call dein#add('jiangmiao/auto-pairs')          "括弧対応入力
call dein#add('tomasr/molokai')                "カラースキーマ
call dein#add('tyru/open-browser.vim')         "カーソル上のURLを表示
call dein#add('rhysd/accelerated-jk')          "j/kによる移動を早くする
call dein#add('tpope/vim-surround')            "タグの挿入 http://vimblog.hatenablog.com/entry/vim_plugin_surround_vim
call dein#add('tpope/vim-fugitive')            "git 使い方 http://myenigma.hatenablog.com/entry/2016/07/10/084048
call dein#add("thinca/vim-quickrun")
call dein#add('plasticboy/vim-markdown')       "Markdownのシンタックス
call dein#add('kannokanno/previm')
call dein#add('lervag/vimtex')
call dein#add('derekwyatt/vim-scala')          "scalaのシンタックス
call dein#add('momota/cisco.vim')
call dein#add('gre/play2vim')                  "scala.html，application.confなどをシンタックスできるように
"
"Python関係
call dein#add("davidhalter/jedi-vim", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"],
      \ },
      \ "build": {
      \   "mac": "pip3 install jedi",
      \   "unix": "pip3 install jedi",
      \ }})
let g:jedi#rename_command = '<Leader>R'

"-----------------------------------------------------
call dein#end()

