#!/bin/bash

#declare -A LISA
LS_DIR=$(dirname $(readlink -f $0))
LS_SCRIPT_DIR="$LS_DIR/scripts"

source $LS_SCRIPT_DIR/util.sh

HANDLE="$1"
ACTION="$2"

if [ -z $HANDLE ]; then
    error 'Please enter script name'
elif [ ! -f "$LS_SCRIPT_DIR/$HANDLE.sh" ]; then
    error "The [$HANDLE] script not found"
fi

source $LS_SCRIPT_DIR/$HANDLE.sh

if [ -z $ACTION ]; then
    error "Please enter a action"
elif [ -z $(type -t $ACTION) ]; then
    error "The function [$ACTION] does not exist"
fi

$ACTION "${@:3}"
