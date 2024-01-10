#!/bin/bash

dimensions="2560 1440"

n=$(xrandr | grep -w connected | awk '{print $1}')
m=$(cvt -r $dimensions | grep Modeline | cut --fields=2- -d ' ')
resn=$(cvt -r $dimensions | grep Modeline | cut --fields=2- -d ' ' | awk '{print $1}')

eval "xrandr --newmode $m"
eval "xrandr --addmode $n $resn"
eval "xrandr --output $n --mode $resn"

#xrandr --output HDMI-1 --mode "1280x1024"
