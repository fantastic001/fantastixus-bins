#!/bin/bash 

usage() {
    echo "Usage: $0 [right|left|above|below|mirror|interactive]"
    exit 1
}

if [ "$#" -ne 1 ]; then
    usage
fi

function detect_connected_displays {
    xrandr | grep " connected" | awk '{ print$1 }'
}

function find_primary_display {
    detect_connected_displays | head -n 1
}

function find_display {
    detect_connected_displays | grep -i "$1"
}

function find_hdmi {
    find_display "HDMI"
}

function find_vga {
    find_display "VGA"
}

function find_displayport {
    find_display "DP"
}

function find_dvi {
    find_display "DVI"
}

function find_lvds {
    find_display "LVDS"
}

function toggle_hdmi {
    if [ -n "$(find_hdmi)" ]; then
        xrandr --output $(find_primary_display) --auto --output $(find_hdmi) --off
    else
        if [ "$1" == "right" ]; then
            xrandr --output $(find_primary_display) --auto --output $(find_hdmi) --auto --right-of $(find_primary_display)
        elif [ "$1" == "left" ]; then
            xrandr --output $(find_primary_display) --auto --output $(find_hdmi) --auto --left-of $(find_primary_display)
        elif [ "$1" == "above" ]; then
            xrandr --output $(find_primary_display) --auto --output $(find_hdmi) --auto --above $(find_primary_display)
        elif [ "$1" == "below" ]; then
            xrandr --output $(find_primary_display) --auto --output $(find_hdmi) --auto --below $(find_primary_display)
        elif [ "$1" == "mirror" ]; then
            xrandr --output $(find_primary_display) --auto --output $(find_hdmi) --auto --same-as $(find_primary_display)
        else
            xrandr --output $(find_primary_display) --auto --output $(find_hdmi) --auto
        fi
    fi
}



if [ "$1" == "interactive" ]; then
    dialog --menu "Select display configuration" 0 0 0 \
        "right" "Right of primary display" \
        "left" "Left of primary display" \
        "above" "Above primary display" \
        "below" "Below primary display" \
        "mirror" "Mirror primary display" \
        "off" "Turn off HDMI" 2> /tmp/toggle_hdmi
    toggle_hdmi $(cat /tmp/toggle_hdmi)
else
    toggle_hdmi $1
fi 
