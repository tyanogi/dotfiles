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
set tabstop=4
set shiftwidth=4
set softtabstop=4

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
nnoremap s= <C-w>=
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-
nnoremap sn gt
nnoremap sp gT
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap uf :<C-u>Unite file<CR>
nnoremap ur :<C-u>Unite file_mru<CR>
nnoremap nt :<C-u>NERDTree<CR>
"map nt :NERDTreeToggle<CR>
"カーソル下のURLをブラウザで開く
nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)
"j/kによる移動を早くする
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)


"noramlモード時に自動英数入力変換
if executable('osascript')
  let s:keycode_jis_eisuu = 102
  let g:force_alphanumeric_input_command = "osascript -e 'tell application \"System Events\" to key code " . s:keycode_jis_eisuu . "' &"

  inoremap <silent> <Esc> <Esc>:call system(g:force_alphanumeric_input_command)<CR>

  autocmd! FocusGained *
    \ call system(g:force_alphanumeric_input_command)
endif


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
NeoBundle 'Shougo/unite.vim'              "ファイル表示
NeoBundle 'Shougo/neomru.vim'             "Unite.vimで最近使ったファイルを表示>できるようにする
NeoBundle 'scrooloose/nerdtree'           "ツリー型でファイルを表示 
NeoBundle 'Xuyuanp/nerdtree-git-plugin'   "ファイルの変更を表示 nerdtree
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
NeoBundle 'airblade/vim-gitgutter'        "ファイルの変更を表示
NeoBundle 'jistr/vim-nerdtree-tabs'       "タブ間ツリー表示
if argc() == 0
    let g:nerdtree_tabs_open_on_console_startup = 1
end
NeoBundle 'Shougo/neocomplcache'          "補完
NeoBundle 'itchyny/lightline.vim'         "ステータスライン
NeoBundle 'Yggdroot/indentLine'           "インデント
NeoBundle 'jiangmiao/auto-pairs'          "括弧対応入力
NeoBundle 'tomasr/molokai'                "カラースキーマ
NeoBundle 'tyru/open-browser.vim'         "カーソル上のURLを表示
NeoBundle 'rhysd/accelerated-jk'          "j/kによる移動を早くする
"NeoBundle 'soramugi/auto-ctags.vim'       "閉じタグ自動補完
NeoBundle 'tpope/vim-surround'            "タグの挿入 http://vimblog.hatenablog.com/entry/vim_plugin_surround_vim
NeoBundle 'tpope/vim-fugitive'            "git 使い方 http://myenigma.hatenablog.com/entry/2016/07/10/084048
"NeoBundle 'taichouchou2/html5.vim'        "html5のシンタックス
NeoBundle 'taichouchou2/vim-javascript'   "jsのシンタックス
NeoBundle 'hail2u/vim-css3-syntax'        "css3のシンタックス
NeoBundle 'thinca/vim-quickrun'           "ソースコードを実行
set splitbelow
set splitright
NeoBundle 'Shougo/neosnippet'             "スニペット機能 http://promamo.com/?p=1944
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

NeoBundle 'Shougo/neosnippet-snippets'    "補完可能な単語が登録された辞書

call neobundle#end()
filetype plugin indent on       " restore filetype

