#!/bin/bash

# <util />
## :: source ::
cwd=$(dirname $(realpath ${BASH_SOURCE[0]:-$0}))
source "$cwd/util.sh"

## :: confirm ::
wr_warn "running this script is destructive"
wr_warn "current configurations may be overriden"
do_confirm=$(ask_yn "do you want to continue?")

[ ! "$do_confirm" ] && exit

# <install />
## :: hyprland ::
wr_note "installing desktop"
"$cwd/install/desktop.sh"
## :: fish ::
wr_note "installing fish shell"
"$cwd/install/fish.sh"
## :: helix ::
wr_note "installing helix"
"$cwd/install/helix.sh"
## :: code ::
wr_note "installing code"
"$cwd/install/code.sh"
