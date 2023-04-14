# credit https://github.com/MathisP75/hyppuccin/blob/main/wofi/powermenu.sh

entries="󰜉 reboot\n󰤆 shutdown\n󰗽 logout\n󰽥 suspend"

selected=$(echo -e $entries | wofi --width 250 --height 260 --dmenu --hide_search --hide-scroll --cache-file /dev/null | awk '{print tolower($2)}')
case $selected in
	logout)
		exec hyprctl dispatch exit NOW;;
	suspend)
		exec systemctl suspend;;
	reboot)
		exec systemctl reboot;;
	shutdown)
		exec systemctl poweroff;;
esac
