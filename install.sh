DOTPATH=~/dotfiles
GITHUB_URL="https://github.com/tyanogi/dotfiles.git"

# git が使えるなら git
if type git > /dev/null 2>&1; then
    git clone --recursive -b auto_configuration "$GITHUB_URL" "$DOTPATH"
    #git clone --recursive "$GITHUB_URL" "$DOTPATH"

# 使えない場合は curl か wget を使用する
elif type curl > /dev/null 2>&1 || type wget > /dev/null 2>&1; then
    tarball="https://github.com/tyanogi/dotfiles/archive/master.tar.gz"
    mkdir $DOTPATH

    # どっちかでダウンロードして，tar に流す
    if type curl > /dev/null 2>&1; then
        curl -L "$tarball"

    elif type wget > /dev/null 2>&1; then
        wget -O - "$tarball"

    fi | tar zxv

    # 解凍したら，DOTPATH に置く
    mv -f dotfiles-master "$DOTPATH"

else
    die "curl or wget required"
fi

cd ~/dotfiles
if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi

make

