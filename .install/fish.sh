#!/bin/bash

wr_note () { echo -e "[\e[1;34mnote\e[0m] $1"; }
wr_warn () { echo -e "[\e[1;33mwarn\e[0m] $1"; }
wr_done () { echo -e "[\e[1;32mdone\e[0m] $1"; }
wr_okay () { echo -e "[\e[1;36mokay\e[0m] $1"; }
wr_err  () { echo -e "[\e[1;31merr!\e[0m] $1"; }

# part credit https://stackoverflow.com/a/226724. thx.
ask_yn () {
	while true; do
		read -n1 -rep $'[\e[1;35mask?\e[0m]'" $1 (y/n) " yn
		case $yn in
			[Yy]* ) echo "true"; break;;
			[Nn]* ) break;;
		esac
	done
}

check_does_exist () {
	local ch=$(command -v $1)
	if [ ! $ch ]; then
		wr_err "not found: \$($1)"
		wr_err "aborting..."
		exit
	fi
}

do_install () {
	if yay -Qs $1 > /dev/null ; then
		wr_okay "$1 is already installed"
	else
		wr_note "installing $1 ..."
		yay -S --noconfirm $1
		if yay -Qs $1 > /dev/null ; then
			wr_okay "$1 is installed"
		else
			wr_err "failed installing $1"
			exit
		fi
	fi
}


check_does_exist "yay"
check_does_exist "curl"

yn_do=$(ask_yn "do you want to install the fish shell and plugins?")
[ ! $yn_do ] && exit

do_install "fish"
do_install "fisher"

wr_note "installing fish plugins"
wr_note "[ m4rch3n1ng/may.fish, m4rch3n1ng/ssh-agent.fish ]"

fisher install "m4rch3n1ng/may.fish"
fisher install "m4rch3n1ng/ssh-agent.fish"

wr_okay "installed fish plugins"

wr_note "downloading config.fish"
curl https://raw.githubusercontent.com/m4rch3n1ng/dotfiles/main/arch/.config/fish/config.fish > ~/.config/fish/config.fish
touch ~/.config/fish/functions/fish_greeting.fish
