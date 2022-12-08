#!/bin/bash

curr=$( setxkbmap -print -verbose 10 | grep layout | awk '{print $2}' )

if [ "$curr" == us ]; then
    setxkbmap ru
else
    setxkbmap us
fi
