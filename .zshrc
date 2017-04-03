# ------------------------------------------------------------------------------------------------------------
# - * File: .zshrc
# - * Author: tyanogi
# ------------------------------------------------------------------------------------------------------------

# 補完機能
autoload -U compinit
compinit

# キーバインドをvimにする
bindkey -v
bindkey -M viins '^J' vi-cmd-mode
bindkey -a '^J' vi-forward-word
# zshプロンプトにモード表示
# 設定1
function zle-line-init zle-keymap-select {
    VIM_NORMAL="%K{148}%F{black}⮀%k%f%K{148}%F{green} % NORMAL %k%f%K{black}%F{148}⮀%k%f"
    VIM_INSERT="%K{027}%F{black}⮀%k%f%K{027}%F{white} % INSERT %k%f%K{black}%F{027}⮀%k%f"
    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    zle reset-prompt

# 設定2
#    case $KEYMAP in
#        vicmd)
#        PROMPT="%{$fg[red]%}[%{$reset_color%}%n/%{$fg_bold[red]%}NOR%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} "
#        ;;
#        main|viins)
#        PROMPT="%{$fg[red]%}[%{$reset_color%}%n/%{$fg_bold[cyan]%}INS%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} "
#        ;;
#    esac
#    zle reset-prompt
}
#RPS1="%n@%m ${VIMODE} \\$ "
RPS1="%n@%m:%~$VIMODE\$ "
PROMPT=$RPS1
zle -N zle-line-init
zle -N zle-keymap-select

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

# ディレクトリの移動
alias ...='cd ../..'
alias ....='cd ../../..'

# タイプミス
alias vikm='vim'

# ディレクトリに色をつける
autoload -U compinit
compinit

#export LSCOLORS=exfxcxdxbxegedabagacad
export LSCOLORS=cxfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias ls="ls -GF"
alias gls="gls --color"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

disable r

export PATH=$PATH:~/.composer/vendor/bin
#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

