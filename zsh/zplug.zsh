# Source zplug and all zplug managed plugins
source ~/.zplug/init.zsh

zplug "rupa/z", use:z.sh
zplug "changyuheng/fz"
zplug "qianxinfeng/vscode"
zplug "supercrabtree/k"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
