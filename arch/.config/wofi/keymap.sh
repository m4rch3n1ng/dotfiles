entries="normal\ncompose"

selected=$(echo -e $entries | wofi --width 250 --height 260 --dmenu --hide-scroll --cache-file /dev/null | awk '{print tolower($1)}')

case $selected in
	compose)
		hyprctl keyword input:kb_file ~/.config/keymap/comp.xkb
		;;
	normal)
		hyprctl keyword input:kb_file ~/.config/keymap/may.xkb
		;;
esac
