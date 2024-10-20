#!/usr/bin/env sh

CONFIG_LOCATION=/home/"$USER"/.config/polybar/config.ini
killall -q polybar

for bar in "$HOME"/.config/polybar/bars/*
do
    bar=${bar##*/}
    bar=${bar%%.*}
    MONITOR=$DISPLAY_PRIMARY polybar --reload "$bar" -q -c "$CONFIG_LOCATION" &
done

echo "Bar launched..."