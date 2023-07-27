#!/bin/bash

is_power=$(bluetoothctl show | grep -i powered | grep -i yes)

if [ "$is_power" ]; then
	bluetoothctl power off
else
	bluetoothctl power on
fi
