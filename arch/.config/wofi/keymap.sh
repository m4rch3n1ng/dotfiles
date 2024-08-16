#!/bin/bash

entries="may\nbasic"
selected=$(echo -e $entries | wofi --width 250 --height 260 --dmenu --hide-scroll --cache-file /dev/null | awk '{print tolower($1)}')

case $selected in
	may)
		hyprctl keyword input:kb_file ~/.config/keymap/may.xkb
		;;
	basic)
		hyprctl keyword input:kb_file ~/.config/keymap/basic.xkb
		;;
esac
