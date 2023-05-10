#!/bin/bash

# <packages />
# thx https://github.com/SolDoesTech/HyprV2/blob/main/set-hypr
# installed packages:
# 
# desktop environment
## hyprland - the hyprland wayland composior
## waybar-hyprland - waybar with hyprland workspace support
## wofi - app launcer
## mako - notification manager
## swww - desktop background
## swaylock-effects - lock screen
## kitty - default terminal
## thunar - file manager
## gvfs - extend thunar
## gvfs-mtp - extend thunar: android support
## thunar-media-tags-plugin - extend thunar: media tags
# 
# things
## polkit-gnome - get root access for some gui apps
## xdg-desktop-portal-hyprland-git - xdg desktop portal for hyprland
## hyprpicker-git - hyprland color picker
## hyprshot ?
## swappy - edit screenshots
## grim - take screenshot
## slurp - select screen space
## wl-clipboard - cli clipboard for wayland
## clipmon-git - clipboard manager
# 
# interfacing
## pamixer - cli audio mixer
## pavucontrol - gui audio mixer
## brightnessctl - cli brightness control
## bluez - bluetooth service
## bluez-utils - cli bluetooth manager
## blueman - gui bluetooth manager
## network-manager-applet - wifi / connection manager
# 
# tools
## p7zip - 7-zip compression package
## p7zip-gui - gui for p7zip
## trashy - trash manager
## pacman-contrib - additional pacman tools
## jq - cli json formatter
# 
# ui
## noto-fonts - noto fonts
## noto-fonts-cjk - noto fonts for chinese, japanese, korean
## noto-fonts-emoji - not fonts emojis
## noto-fonts-extra - noto fonts extra emojis
## ttf-fira-code - programming font
## ttf-fira-mono - fira code w/o ligatures
## ttf-jetbrains-mono - main monospace font
## ttf-material-design-icons-git - material design icons for waybar, etc
## ttf-jetbrains-mono-nerd - patched monospace font (for debug)
## lxappearance - set gtk theme
## xfce4-settings - needed for gtk theme
# 

# <util />
cwd=$(dirname $(realpath ${BASH_SOURCE[0]:-$0}))
source "$cwd/../util.sh"

check_manual_install () {
	local ch=$(command -v $1)

	if [ ! $ch ]; then
		wr_warn "not found $1"
		local yn_inst=$(ask_yn "do you want to install $1?")
		if [ $yn_inst ]; then
			git_tmp_path=$(mktemp -d -t may-hypr.XXXXXXXXXXXX)
			git_tmp_url="https://aur.archlinux.org/$1.git"

			cd $git_tmp_path

			wr_note "installing $1"

			git clone $git_tmp_url .
			makepkg -si

			wr_done "installed $1"
			cd $HOME
		else
			wr_err "cannot continue script without $1"
			exit
		fi
	fi
}

# <check />
check_manual_install "yay"
do_install "git"

# is_laptop=$(ask_yn "are you running on a laptop?")

# <install />
yay -Syu --noconfirm

for soft in \
	hyprland waybar-hyprland wofi mako swww swaylock-effects \
	kitty thunar gvfs gvfs-mtp thunar-media-tags-plugin \
	polkit-gnome xdg-desktop-portal-hyprland-git \
	hyprshot swappy grim slurp wl-clipboard clipmon-git \
	pamixer pavucontrol brightnessctl bluez bluez-utils blueman network-manager-applet \
	p7zip p7zip-gui trashy jq pacman-contrib \
	noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
	ttf-fira-code ttf-fira-mono ttf-jetbrains-mono ttf-material-design-icons-git ttf-jetbrains-mono-nerd \
	lxappearance xfce4-settings
do
	do_install $soft
done

# <config />
wr_note "linking desktop configs"
## hyprland
wr_note "linking hyprland config"
link_dotfiles "arch/.config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
link_dotfiles "arch/.config/hypr/keybinds.conf" "$HOME/.config/hypr/keybinds.conf"
link_dotfiles "arch/.config/hypr/windowrule.conf" "$HOME/.config/hypr/windowrule.conf"
copy_dotfiles "arch/.config/hypr/wallpaper.gif" "$HOME/.config/hypr/wallpaper.gif"
link_dotfiles "arch/.config/hypr/xdg-portal-hyprland.sh" "$HOME/.config/hypr/xdg-portal-hyprland.sh"
## waybar
wr_note "linking waybar config"
link_dotfiles "arch/.config/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
link_dotfiles "arch/.config/waybar/style.css" "$HOME/.config/waybar/style.css"
## wofi
wr_note "linking wofi config"
link_dotfiles "arch/.config/wofi/config" "$HOME/.config/wofi/config"
link_dotfiles "arch/.config/wofi/style.css" "$HOME/.config/wofi/style.css"
link_dotfiles "arch/.config/wofi/power-menu.sh" "$HOME/.config/wofi/power-menu.sh"
## mako
wr_note "linking mako config"
link_dotfiles "arch/.config/mako/config" "$HOME/.config/mako/config"
## kitty
wr_note "linking kitty config"
link_dotfiles "arch/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
link_dotfiles "arch/.config/kitty/theme.conf" "$HOME/.config/kitty/theme.conf"

# <misc />
wr_note "linking misc config"
## font
link_dotfiles "arch/.config/fontconfig/fonts.conf"
## keymap
wr_note "linking keymap"
link_dotfiles "arch/.config/keymap/may.xkb" "$HOME/.config/keymap/may.xkb"

# <done />
wr_okay "done hyprland.sh"
