#!/bin/bash

# <util />
cwd=$(dirname $(realpath ${BASH_SOURCE[0]:-$0}))
source "$cwd/../util.sh"

check_does_exist "paru"

# <install />
do_install "helix"

# <config />
wr_note "linking helix config"
link_dotfiles "arch/.config/helix/config.toml" "$HOME/.config/helix/config.toml"
link_dotfiles "arch/.config/helix/languages.toml" "$HOME/.config/helix/languages.toml"
link_dotfiles "arch/.config/helix/themes/fix_solarized_light.toml" "$HOME/.config/helix/themes/fix_solarized_light.toml"

# <done />
wr_okay "done helix.sh"
