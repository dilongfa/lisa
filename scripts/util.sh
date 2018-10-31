#!/bin/bash

error() {
    echo -e "\e[33m${1}\e[0m"
    exit 1
}

success() {
    echo -e "\e[32m${1}\e[0m"
    exit 1
}

system_update() {
    sudo apt-get update
}

system_upgrade() {
    # Khong dung dist-upgrade cho production server
    sudo apt-get upgrade
}

get_sudo() {
    if [[ $UID != 0 ]]; then
        echo "Please run this script with sudo:"
        echo "sudo $0 $*"
        exit 1
    fi
}