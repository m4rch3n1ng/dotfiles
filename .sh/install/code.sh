#!/bin/bash

# <util />
cwd=$(dirname $(realpath ${BASH_SOURCE[0]:-$0}))
source "$cwd/../util.sh"

check_does_exist "yay"
do_install "p7zip"
do_install "curl"

# <install />
do_install "code"
do_install "code-marketplace"

# <replace icon path />
replace_icon () {
	local icon_tmp_path=$(mktemp -d -t may-code.XXXXXXXXXXXX)
	cd $icon_tmp_path

	wr_note "downloading visual-studio-code-icons.zip"
	curl "https://vscodeassets.azureedge.net/public/visual-studio-code-icons.zip" -o "visual-studio-code-icons.zip"
	7z x "visual-studio-code-icons.zip"

	wr_note "copying to ~/.icons/com.visualstudio.code.oss.png"
	[[ ! -d "$HOME/.icons" ]] && mkdir "$HOME/.icons"
	[[ -e "$HOME/.icons/com.visualstudio.code.oss.png" ]] && rm "$HOME/.icons/com.visualstudio.code.oss.png"
	cp "$icon_tmp_path/visual-studio-code-icons/vscode.png" "$HOME/.icons/com.visualstudio.code.oss.png"
	wr_done "copying icon"
}

replace_icon

# <config />
## link config [todo]
wr_note "linking vscode config"
link_dotfiles "shared/vscode/settings.json" "$HOME/.config/Code - OSS/User/settings.json"
link_dotfiles "shared/vscode/keybindings.json" "$HOME/.config/Code - OSS/User/keybindings.json"
## install extensions
wr_note "installing vscode extensions"
cat "$DOTFILES/shared/vscode/extensions.txt" | xargs -n1 code --install-extension
