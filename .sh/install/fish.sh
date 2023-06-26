#!/bin/bash

# <util />
cwd=$(dirname $(realpath ${BASH_SOURCE[0]:-$0}))
source "$cwd/../util.sh"

check_does_exist "yay"

# <install />
do_install "fish"
do_install "fisher"

# <plugins />
wr_note "installing fish plugin"
wr_note "[ m4rch3n1ng/may.fish ]"

fisher install "m4rch3n1ng/may.fish"
wr_okay "installed fish plugin"

# <config />
## greet
wr_note "creating ~/.config/fish/functions/fish_greeting.fish"
touch "$HOME/.config/fish/functions/fish_greeting.fish"
## link
wr_note "linking fish config"
link_dotfiles "arch/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
## default shell
wr_note "changing default shell"
chsh -s /usr/bin/fish

# <done />
wr_okay "done fish.sh"
