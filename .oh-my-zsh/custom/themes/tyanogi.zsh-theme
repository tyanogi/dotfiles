# ------------------------------------------------------------------------------------------------------------
# - * File: .tyanogi.zsh-theme
# - * Author: tyanogi
# ------------------------------------------------------------------------------------------------------------
autoload -Uz colors
colors

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue"

# キーバインドをvimにする
bindkey -v
bindkey -M viins '^J' vi-cmd-mode
bindkey -a '^J' vi-forward-word

function str_with_color() {
    echo "%{$fg[$1]%}$2%{$reset_color%}"
}

function update_prompt() {
    ACTIVE_KUBE=""
    KUBECTX_INFO=$(str_with_color cyan $(kubectx_prompt_info))
    KUBENS_INFO=$(str_with_color cyan $(kubens_prompt_info))
    if [[ -n "${KUBECTX_INFO}" && -n "${KUBENS_INFO}" ]]; then
        ACTIVE_KUBE=${LEFT_PARENTHESIS}${KUBECTX_INFO}${SEPARATOR2}${KUBENS_INFO}${RIGHT_PARENTHESIS}
    fi
}

# git
# vcs_infoロード    
autoload -Uz vcs_info    
# PROMPT変数内で変数参照する    
setopt prompt_subst    
# vcsの表示    
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() {
    vcs_info
    update_prompt
}    

# kubectx mapping
kubectx_mapping[kubernetes-admin@kubernetes]="raspi_k8s"
kubectx_mapping[kind-kind]="kind"

# Vimのモードを表示
function zle-line-init zle-keymap-select {
    VIM_NORMAL="%K{148}%F{028}--%k%f%K{148}%F{028} % NORMAL --%k%f"
    VIM_INSERT="%K{027}%F{white}--%k%f%K{027}%F{white} % INSERT --%k%f"
    RPROMPT="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# プロンプト表示    
USER_NAME=$(str_with_color blue '%n')
SEPARATOR1=$(str_with_color magenta '@')
HOST_NAME=$(str_with_color blue '%m')
SEPARATOR2=$(str_with_color magenta '->')
SEPARATOR3=$(str_with_color white ':')
CURRNET_DIRECTORY=$(str_with_color green '%~')
SEPARATOR4=$(str_with_color magenta '>> ')
TIME=$(str_with_color green '[%*]')
LEFT_PARENTHESIS=$(str_with_color magenta '(')
RIGHT_PARENTHESIS=$(str_with_color magenta ')')

LINE1='${TIME} ${USER_NAME}${SEPARATOR1}${HOST_NAME}${vcs_info_msg_0_}${ACTIVE_KUBE}${SEPARATOR3}${CURRNET_DIRECTORY} '$'\n'
LINE2="${SEPARATOR4}"
PROMPT="${LINE1}${LINE2}"
RPROMPT="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"