#!/bin/bash

# ZSHカスタムディレクトリの定義
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/dotfiles/.oh-my-zsh/custom}"

# プラグインのURLマッピング
declare -A plugin_urls
plugin_urls=(
    ["zsh-completions"]="https://github.com/zsh-users/zsh-completions.git"
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    ["zsh-active-kubens"]="https://github.com/tyanogi/zsh-active-kubens.git"
)

# プラグインディレクトリ作成
mkdir -p "$ZSH_CUSTOM/plugins"

# オプションの処理
update_mode=false

while getopts ":u" opt; do
    case "$opt" in
        u)
            update_mode=true
            ;;
        \?)
            echo "Usage: $0 [-u]"
            exit 1
            ;;
    esac
done

# 各プラグインをクローンまたは更新
echo "Install to '$ZSH_CUSTOM'"
for plugin in "${!plugin_urls[@]}"; do
    plugin_dir="$ZSH_CUSTOM/plugins/$plugin"
    repo_url="${plugin_urls[$plugin]}"

    if [ -d "$plugin_dir/.git" ]; then
        if [ "$update_mode" = true ]; then
            echo "Updating $plugin..."
            git -C "$plugin_dir" pull
        else
            echo "$plugin already exists. Use '-u' to update."
        fi
    else
        echo "Cloning $plugin..."
        git clone "$repo_url" "$plugin_dir"
    fi
done

echo "All plugins have been set up successfully."
