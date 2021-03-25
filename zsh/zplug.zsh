# Source zplug and all zplug managed plugins
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "qianxinfeng/vscode"
zplug "supercrabtree/k"
zplug "ajeetdsouza/zoxide"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
