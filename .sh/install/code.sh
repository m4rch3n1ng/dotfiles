#!/bin/bash

# <util />
cwd=$(dirname $(realpath ${BASH_SOURCE[0]:-$0}))
source "$cwd/../util.sh"

check_does_exist "paru"
do_install "p7zip"
do_install "curl"

# <install />
do_install "code"
do_install "code-marketplace"

# <config />
## link config [todo]
wr_note "linking vscode config"
link_dotfiles "shared/vscode/settings.json" "$HOME/.config/Code - OSS/User/settings.json"
link_dotfiles "shared/vscode/keybindings.json" "$HOME/.config/Code - OSS/User/keybindings.json"
## install extensions
wr_note "installing vscode extensions"
cat "$DOTFILES/shared/vscode/extensions.txt" | xargs -n1 code --install-extension
