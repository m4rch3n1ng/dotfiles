#!/bin/bash

# <env />
_cwd=$(realpath $(dirname ${BASH_SOURCE[0]:-$0}))
DOTFILES=$(dirname $_cwd)

unset -f _cwd

# <log />
wr_note () { echo -e "[\e[1;34mnote\e[0m] $@"; }
wr_warn () { echo -e "[\e[1;33mwarn\e[0m] $@"; }
wr_done () { echo -e "[\e[1;32mdone\e[0m] $@"; }
wr_okay () { echo -e "[\e[1;36mokay\e[0m] $@"; }
wr_err  () { echo -e "[\e[1;31merr!\e[0m] $@"; }

# <ask />
## part credit https://stackoverflow.com/a/226724. thx.
ask_yn () {
	while true; do
		read -n1 -rep $'[\e[1;35mask?\e[0m]'" $1 (y/n) " yn
		case $yn in
			[Yy]* ) echo "true"; break;;
			[Nn]* ) break;;
		esac
	done
}

# <pacman />
check_does_exist () {
	local ch=$(command -v "$1")
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

# <dotfiles />
link_dotfiles () {
	local dots="$DOTFILES/$1"
	local conf="$2"

	wr_note "linking $dots to $conf"
	local conf_dir=$(dirname "$conf")
	if [ ! -d "$conf_dir" ]; then
		mkdir -p "$conf_dir"
	fi

	if [ -f "$conf" ]; then
		rm "$conf"
	fi

	ln -s "$dots" "$conf"
}

copy_dotfiles () {
	local dots=$DOTFILES/$1
	local conf=$2

	wr_note "copying $dots to $conf"
	local conf_dir=$(dirname "$conf")
	if [ ! -d "$conf_dir" ]; then
		mkdir -p "$conf_dir"
	fi

	if [ -f "$conf" ]; then
		rm "$conf"
	fi

	cp "$dots" "$conf"
}
