#!/bin/bash

#
# These should be command-line arguments...
#

MONITOR_CONFIG="2xWUXGA"
FONT_SPEC="M" # "S", "M", "L"
# TERM_SIZE="HALF" # "QUARTER" - determine this from the TERMINAL_SPEC
MONITOR_SPEC="L" # "R" "1"
TERMINAL_SPEC="TL" # "L", "R", "TL", "BL", "TR", "BR" ("M", "TM", "BM")

TERMINAL_SIZE=""

function terminal_size {
    local _terminal_size="UNKNOWN"
    if [[ "$1" == "TL" ]] ||
        [[ "$1" == "BL" ]] ||
        [[ "$1" == "TR" ]] ||
        [[ "$1" == "BR" ]] ||
        [[ "$1" == "TM" ]] ||
        [[ "$1" == "BM" ]]; then
        _terminal_size="QUARTER"
    elif [[ "$1" == "L" ]] ||
        [[ "$1" == "R" ]] ||
        [[ "$1" == "M" ]]; then
        _terminal_size="HALF"
    fi

    echo "$_terminal_size"
}

function standard_fonts {
    local _font="8x13"
    if [[ "$1" == "S" ]]; then
        _font="7x13"
    elif [[ "$1" == "M" ]]; then
        _font="8x13"
    elif [[ "$1" == "L" ]]; then
        _font="9x15"
    else
        echo "ERROR: Didn't process font size: $1"
    fi

    echo "$_font"
}

function fullhd_position {
    local _monitor="$1"
    local _terminal_location="$2"

    echo $(build_position "$_monitor" "$_terminal_location" "+5" "+670" "-1925" "+1925" "+2590" "-69" "+5" "-37" )
}

function fullhd_dimensions {
    local _terminal_size=$1
    local _font_size=$2

    echo $(build_dimensions "$_terminal_size" "$_font_size" "38" "78" "38" "78" "32" "68")
}

function wuxga_position {
    local _monitor="$1"
    local _terminal_location="$2"

    echo $(build_position "$_monitor" "$_terminal_location" "+5" "+670" "-1925" "+1925" "+2590" "-69" "+5" "-37" )
}

function wuxga_dimensions {
    local _terminal_size=$1
    local _font_size=$2

    echo $(build_dimensions "$_terminal_size" "$_font_size" "42" "87" "42" "87" "36" "75")
}

function build_dimensions {
    local _dimensions="80x24"
    local _terminal_size=$1
    local _font_size=$2
    local _s_q_lines=$3
    local _s_h_lines=$4
    local _m_q_lines=$5
    local _m_h_lines=$6
    local _l_q_lines=$7
    local _l_h_lines=$8

    if [[ "$_font_size" == "S" ]]; then
        if [[ "$_terminal_size" == "QUARTER" ]]; then
            _dimensions="80x$_s_q_lines"
        elif [[ "$_terminal_size" == "HALF" ]]; then
            _dimensions="80x$_s_h_lines"
        else
            echo "ERROR: didn't process terminal size: $_terminal_size"
        fi
    elif [[ "$_font_size" == "M" ]]; then
        if [[ "$_terminal_size" == "QUARTER" ]]; then
            _dimensions="80x$_m_q_lines"
        elif [[ "$_terminal_size" == "HALF" ]]; then
            _dimensions="80x$_m_h_lines"
        else
            echo "ERROR: didn't process terminal size: $_terminal_size"
        fi
    elif [[ "$_font_size" == "L" ]]; then
        if [[ "$_terminal_size" == "QUARTER" ]]; then
            _dimensions="80x$_l_q_lines"
        elif [[ "$_terminal_size" == "HALF" ]]; then
            _dimensions="80x$_l_h_lines"
        else
            echo "ERROR: didn't process terminal size: $_terminal_size"
        fi
    fi

    echo "$_dimensions"
}

function build_position {
    local _pos="+5+5"
    local _monitor="$1"
    local _terminal_location="$2"
    shift
    shift
    local _x_l="$1"
    local _x_m="$2"
    local _x_lr="$3"
    local _x_rl="$4"
    local _x_rm="$5"
    local _x_r="$6"
    local _y_t="$7"
    local _y_b="$8"
    if [[ "$_monitor" == "L" ]]; then
        if [[ "$_terminal_location" == "L" ]] || [[ "$_terminal_location" == "TL" ]]; then
            _pos="${_x_l}${_y_t}"
        elif [[ "$_terminal_location" == "BL" ]]; then
            _pos="${_x_l}${_y_b}"
        elif [[ "$_terminal_location" == "M" ]] || [[ "$_terminal_location" == "TM" ]]; then
            _pos="${_x_m}${_y_t}"
        elif [[ "$_terminal_location" == "BM" ]]; then
            _pos="${_x_m}${_y_b}"
        elif [[ "$_terminal_location" == "R" ]] || [[ "$_terminal_location" == "TR" ]]; then
            _pos="${_x_lr}${_y_t}"
        elif [[ "$_terminal_location" == "BR" ]]; then
            _pos="${_x_lr}${_y_b}"
        else
            echo "ERROR: didn't process terminal location: $_terminal_location"
        fi
    elif [[ "$_monitor" == "R" ]]; then
        if [[ "$_terminal_location" == "L" ]] || [[ "$_terminal_location" == "TL" ]]; then
            _pos="${_x_rl}${_y_t}"
        elif [[ "$_terminal_location" == "BL" ]]; then
            _pos="${_x_rl}${_y_b}"
        elif [[ "$_terminal_location" == "M" ]] || [[ "$_terminal_location" == "TM" ]]; then
            _pos="${_x_rm}${_y_t}"
        elif [[ "$_terminal_location" == "BM" ]]; then
            _pos="${_x_rm}${_y_b}"
        elif [[ "$_terminal_location" == "R" ]] || [[ "$_terminal_location" == "TR" ]]; then
            _pos="${_x_r}${_y_t}"
        elif [[ "$_terminal_location" == "BR" ]]; then
            _pos="${_x_r}${_y_b}"
        else
            echo "ERROR: didn't process terminal location: $_terminal_location"
        fi
    elif [[ "$_monitor" == "1" ]]; then
        if [[ "$_terminal_location" == "L" ]] || [[ "$_terminal_location" == "TL" ]]; then
            _pos="${_x_l}${_y_t}"
        elif [[ "$_terminal_location" == "BL" ]]; then
            _pos="${_x_l}${_y_b}"
        elif [[ "$_terminal_location" == "M" ]] || [[ "$_terminal_location" == "TM" ]]; then
            _pos="${_x_rm}${_y_t}"
        elif [[ "$_terminal_location" == "BM" ]]; then
            _pos="${_x_rm}${_y_b}"
        elif [[ "$_terminal_location" == "R" ]] || [[ "$_terminal_location" == "TR" ]]; then
            _pos="${_x_lr}${_y_t}"
        elif [[ "$_terminal_location" == "BR" ]]; then
            _pos="${_x_lr}${_y_b}"
        else
            echo "ERROR: didn't process terminal location: $_terminal_location"
        fi
    fi

    echo "$_pos"
}

function test_all {
    for fontsize in S M L; do
        echo "*******"
        echo "Fontsize: $fontsize"
        echo "Font: " $(standard_fonts "$fontsize")
        for monitor in L R; do
            echo "Monitor: $monitor"
            for terminal in L TL BL M TM BM R TR BR; do
                echo "Terminal: $terminal"
                echo "wuxga_position = " $(wuxga_position "$monitor" "$terminal")
                term_size=$(terminal_size "$terminal")
                echo "wuxga_dimensions = " $(wuxga_dimensions "$term_size" "$fontsize")
            done
        done
    done
}

ARG_FONT_SIZE="M"
ARG_MONITOR="1"
ARG_TERMINAL="TL"
ARG_COMMAND="/usr/bin/urxvt"

POSITIONAL=()
while [[ $# -gt 0 ]]; do
    arg1=$1

    case $arg1 in
        -f|--font-size)
            ARG_FONT_SIZE="$2"
            shift # past -f / --font-size
            shift # past value
            ;;
        -m|--monitor)
            ARG_MONITOR="$2"
            shift # past -m / --monitor
            shift # past value
            ;;
        -t|--terminal)
            ARG_TERMINAL="$2"
            shift # past -t / --terminal
            shift # past value
            ;;
        -c|--command)
            ARG_COMMAND="$2"
            shift # past -c / --command
            shift # past value
            ;;
        -h|--help)
            help
            exit
            ;;
        *)
            POSITIONAL+=("$1")
            shift
            ;;
    esac
done

TERM_SIZE=$(terminal_size "$ARG_TERMINAL")

# Exec=/usr/bin/urxvt -fn 9x15 -geometry 80x37+670+5

echo ${ARG_COMMAND} -fn $(standard_fonts $ARG_FONT_SIZE) -geometry $(wuxga_dimensions $(terminal_size "$ARG_TERMINAL") "$ARG_FONT_SIZE")$(wuxga_position "$ARG_MONITOR" "$ARG_TERMINAL")
${ARG_COMMAND} -fn $(standard_fonts $ARG_FONT_SIZE) -geometry $(wuxga_dimensions $(terminal_size "$ARG_TERMINAL") "$ARG_FONT_SIZE")$(wuxga_position "$ARG_MONITOR" "$ARG_TERMINAL") &

# TERMINAL_SIZE=$(terminal_size "$TERMINAL_SPEC")

# echo "TERMINAL_SIZE = $TERMINAL_SIZE"

# if [[ "$MONITOR_CONFIG" == "2xWUXGA" ]]; then
#     FONT=$(standard_fonts "$FONT_SPEC")
#     echo "FONT = $FONT"
# fi

# echo "wuxga_position = " $(wuxga_position "$MONITOR_SPEC" "$TERMINAL_SPEC")

# echo "wuxga_dimensions = " $(wuxga_dimensions "$TERMINAL_SPEC" "$FONT_SPEC")

## test_all