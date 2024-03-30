#!/bin/bash

cliphist list | wofi --dmenu --cache-file /dev/null | cliphist decode | wl-copy && ydotool key 97:1 47:1 97:0 47:0
