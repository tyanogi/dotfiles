# ------------------------------------------------------------------------------------------------------------
# - * File: .zshrc
# - * Author: tyanogi
# ------------------------------------------------------------------------------------------------------------

source ~/dotfiles/local-env.zsh

# ---------------------------------------------------
# ▼ Mise (Tool Manager) ▼
# ---------------------------------------------------
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# ---------------------------------------------------
# ▼ Completion (補完機能) ▼
# ---------------------------------------------------
autoload -U compinit
compinit
## 補完候補をハイライトする
zstyle ':completion:*:default' menu select=2
## 補完候補のオプションやディレクトリで分けて表示する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
## マッチ種別を別々に表示
zstyle ':completion:*' group-name ''
## LS_COLORSを設定しておく
# export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LS_COLORS='di=1;36:fi=1;37:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
## ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ---------------------------------------------------
# ▼ History Settings (履歴設定) ▼
# ---------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# プロセスを横断してヒストリを共有
setopt inc_append_history
## ヒストリの共有の有効化
setopt share_history
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
# ヒストリに追加されるコマンドが古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# 大文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ---------------------------------------------------
# ▼ Command Alias ▼
# ---------------------------------------------------
# editor
alias vim='nvim'
# tmux
alias t='tmux'

# ---------------------------------------------------
# ▼ Plugin Settings ▼
# ---------------------------------------------------
# 1. 色の設定
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

# 2. サジェスト戦略の設定
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# 3. 非同期モードの有効化
ZSH_AUTOSUGGEST_USE_ASYNC=1

# ---------------------------------------------------
# ▼ Key Bindings (History Search) ▼
# ---------------------------------------------------
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# ---------------------------------------------------
# ▼ Oh My Posh (プロンプト) ▼
# ---------------------------------------------------
if [ -f "$HOME/dotfiles/tyanogi.omp.yaml" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/dotfiles/tyanogi.omp.yaml)"
else
  eval "$(oh-my-posh init zsh)"
fi

# ---------------------------------------------------
# ▼ Sheldon (プラグイン管理) (★最後に移動しました) ▼
# ---------------------------------------------------
# プラグイン読み込みは必ず最後に行う
eval "$(sheldon source)"

# ---------------------------------------------------
# ▼ Vim Mode Settings (★ここへ移動しました) ▼
# ---------------------------------------------------
# 1. Vimモードを有効化
bindkey -v

# 2. キーバインド設定
# インサートモードで Ctrl+j を押すとノーマルモードへ
bindkey -M viins '^J' vi-cmd-mode
# ノーマルモードで Ctrl+j を押すと単語移動
bindkey -a '^J' vi-forward-word

# 3. モード切替ロジック
function zle-line-init zle-keymap-select {
    # メインまたはインサートモードの場合
    if [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == '' ]]; then
        export POSH_VI_MODE="INSERT"
    else
        # それ以外（vicmdなど）はNORMAL扱い
        export POSH_VI_MODE="NORMAL"
    fi
    zle reset-prompt
}

# ウィジェットとして登録
zle -N zle-line-init
zle -N zle-keymap-select

# ---------------------------------------------------
# ▼ eza Configuration (ls replacement) ▼
# ---------------------------------------------------
if command -v eza >/dev/null 2>&1; then
  # エイリアス設定 (ls や ll で eza を呼び出す)
  alias ls='eza --icons --git'
  alias ll='eza -la --icons --git --header --time-style=long-iso'

  # EZA_COLORS 設定
  # di=1;36 : ディレクトリ (太字シアン)
  # ln=1;35 : シンボリックリンク (太字マゼンタ)
  # fi=37   : 通常ファイル (白)
  # xx=1;37 : 句読点・矢印など (太字白) ← ★これで矢印が見えるようになります
  export EZA_COLORS="di=1;36:ln=1;35:fi=37:xx=1;37:ex=31:so=32:pi=33:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
fi
