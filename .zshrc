# 補完機能
autoload -U compinit
compinit

# 入力したコマンドが存在せず, かつディレクトリ名が一致するならcd
setopt auto_cd

# "cd [Tab]" 移動履歴の表示
setopt auto_pushd

# pushdした時にディレクトリがすでにスタックに含まれていれば追加しない 
setopt pushd_ignore_dups

# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
setopt hist_ignore_all_dups

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
setopt hist_ignore_space

# コマンド訂正
setopt correct

# 補完候補を詰めて表示
setopt list_packed

# ビープ音off
setopt nolistbeep

#ディレクトリの移動
alias ...='cd ../..'
alias ....='cd ../../..'

#タイプミス
alias vikm='vim'

