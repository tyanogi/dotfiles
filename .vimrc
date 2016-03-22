"View ------------------------------------------------
set number                       "行番号
set showmatch                    "括弧の対応をハイライト
set showcmd                      "入力中のコマンドを表示
set list lcs=tab:\|\ ,eol:↲      " 不可視文字表示
set laststatus=2
set cursorline                   "カーソル行をハイライト
syntax on
colorscheme molokai

" 全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif


"Indent ----------------------------------------------
"" タブ設定
set expandtab                    "タブをスペースに変換
set tabstop=3
set shiftwidth=3
set softtabstop=3

set autoindent
set smartindent


"Search
set wrapscan                     "最後まで検索したら最初に戻る
set ignorecase                   "大文字小文字無視
set smartcase                    "大文字ではじめたら大文字小文字無視しない


set noswapfile


"SortCat
noremap <C-j> <esc>
noremap! <C-j> <esc>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap uf :<C-u>Unite file<CR>


"Pacage Control --------------------------------------
set nocompatible
filetype off            " for NeoBundle

if has('vim_starting')
        set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" ここから NeoBundle でプラグインを設定します

" NeoBundle で管理するプラグインを追加します。
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'             
"Unite.vimで最近使ったファイルを表示>できるようにする
NeoBundle 'Shougo/neocomplcache'          "補完
NeoBundle 'itchyny/lightline.vim'         "ステータスライン
NeoBundle 'Yggdroot/indentLine'           "インデント
NeoBundle 'jiangmiao/auto-pairs'          "括弧対応入力
NeoBundle 'tomasr/molokai'                "カラースキーマ
NeoBundle 'Shougo/neosnippet'
" Plugin key-mappings.
 imap <C-k>     <Plug>(neosnippet_expand_or_jump)
 smap <C-k>     <Plug>(neosnippet_expand_or_jump)
 xmap <C-k>     <Plug>(neosnippet_expand_target)

 " SuperTab like snippets behavior.
 imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: "\<TAB>"

  " For snippet_complete marker.
   if has('conceal')
      set conceallevel=2 concealcursor=i
   endif

NeoBundle 'Shougo/neosnippet-snippets'

call neobundle#end()
filetype plugin indent on       " restore filetype

