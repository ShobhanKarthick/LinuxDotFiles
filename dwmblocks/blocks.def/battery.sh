#!/bin/sh
#ICON=$'\360\237\224\213'
ICON=$'\360\237\224\213'
read -r capacity </sys/class/power_supply/BAT0/capacity
printf "$ICON%s%%" "$capacity"
