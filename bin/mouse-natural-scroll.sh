#!/bin/bash

# Enable "natural scrolling" (reverse mouse wheel) in Linux

# get the mouseid by filtering output of xinput --list
# matches id of first device with word "mouse"
mouseid=$(xinput --list | sed -E '/mouse/I!d;s/.*?mouse.*?id=([0-9]+).*/\1/i;q')

echo $mouseid

# set natural scrolling property to given mouseid
xinput --set-prop $mouseid 'libinput Natural Scrolling Enabled' 1
