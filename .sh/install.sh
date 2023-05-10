#!/bin/bash

## <util />
cwd=$(dirname $(realpath ${BASH_SOURCE[0]:-$0}))
source "$cwd/util.sh"

# <hyprland />
wr_note "installing hyprland desktop"
"$cwd/install/hyprland.sh"

# <fish />
wr_note "installing fish shell"
"$cwd/install/fish.sh"

# <code />
wr_note "installing code"
"$cwd/install/code.sh"
