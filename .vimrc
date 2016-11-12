" ------------------------------------------------------------------------------------------------------------
" - * File: .vimrc
" - * Author: tyanogi
" ------------------------------------------------------------------------------------------------------------

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
syntax enable
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


" swapファイルを作成しない
set noswapfile
" ビジュアルモードで選択したテキストが、クリップボードに入るようにする
set clipboard=autoselect
" 無名レジスタに入るデータを、*レジスタにも入れる。
set clipboard+=unnamed
set clipboard=unnamedplus


"SortCat
noremap <C-j> <esc>
noremap! <C-j> <esc>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sx <C-w>x
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sX <C-w>X
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
nnoremap vs :<C-u>VimShell<CR>
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
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')

call dein#add('Shougo/vimshell.vim')
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '
call dein#add('Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ })
call dein#add('Shougo/unite.vim')              "ファイル表示
call dein#add('Shougo/neomru.vim')             "Unite.vimで最近使ったファイルを表示>できるようにする
call dein#add('scrooloose/nerdtree')           "ツリー型でファイルを表示 
call dein#add('Xuyuanp/nerdtree-git-plugin')   "ファイルの変更を表示 nerdtree
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
call dein#add('airblade/vim-gitgutter')        "ファイルの変更を表示
call dein#add('jistr/vim-nerdtree-tabs')       "タブ間ツリー表示
if argc() == 0
    let g:nerdtree_tabs_open_on_console_startup = 1
end
call dein#add('Shougo/neocomplcache')          "補完
call dein#add('itchyny/lightline.vim')         "ステータスライン
call dein#add('Yggdroot/indentLine')           "インデント
call dein#add('jiangmiao/auto-pairs')          "括弧対応入力
call dein#add('tomasr/molokai')                "カラースキーマ
call dein#add('altercation/vim-colors-solarized')
call dein#add('tyru/open-browser.vim')         "カーソル上のURLを表示
call dein#add('rhysd/accelerated-jk')          " j/kによる移動を早くする
"call dein#add('soramugi/auto-ctags.vim')       "閉じタグ自動補完
call dein#add('tpope/vim-surround')            "タグの挿入 http://vimblog.hatenablog.com/entry/vim_plugin_surround_vim
call dein#add('tpope/vim-fugitive')            "git 使い方 http://myenigma.hatenablog.com/entry/2016/07/10/084048
"call dein#add('taichouchou2/html5.vim')        "html5のシンタックス
call dein#add('taichouchou2/vim-javascript')   "jsのシンタックス
call dein#add('hail2u/vim-css3-syntax')        "css3のシンタックス
call dein#add('fatih/vim-go')                  "goの開発環境 https://github.com/fatih/vim-go
"goのインデントはハードタブ推奨
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
" go runのキーマッピング
au FileType go nmap gr (go-run)
" vim-goの設定
"let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1
" GoFmt時にインポートするパッケージを整理(GoFmtはファイル書き込み時に自動的に実行される)
let g:go_fmt_command = "goimports"
" Highlight
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" Sysntastic
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
call dein#add('thinca/vim-quickrun')           "ソースコードを実行
set splitbelow
set splitright
call dein#add('Shougo/neosnippet')            "スニペット機能 http://promamo.com/?p=1944
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

call dein#add('Shougo/neosnippet-snippets')    "補完可能な単語が登録された辞書

call dein#end()

syntax on

