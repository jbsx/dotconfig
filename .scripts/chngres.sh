#!/bin/bash

n=$(xrandr | grep -w connected | awk '{print $1}')
m=$(cvt -r 1920 1080 | grep Modeline | cut --fields=2- -d ' ')
resn=$(cvt -r 1920 1080 | grep Modeline | cut --fields=2- -d ' ' | awk '{print $1}')

ts1="xrandr --newmode $m"
ts2="xrandr --addmode $n $resn"
ts3="xrandr --output $n --mode $resn"

eval $ts1
eval $ts2
eval $ts3
