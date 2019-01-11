#!/usr/bin/env bash

DIR=$(dirname $(readlink -f $0))
MODULE_DIR="$DIR/modules"
CONFIG_DIR="$DIR/configs"
NGINX_VHOST_DIR="/etc/nginx/conf.d"
HOME_PROJECT_DIR="/home/long/projects"

source "$DIR/util.sh"

if [ "$#" -lt 2 ]; then
    info "Usage: [sudo] lisa {HANDLE} {ACTION} [OPTIONS]"
fi

source "$MODULE_DIR/$1.sh"

if [ "$(type -t $2)" != "function" ]; then
    error "The [$2] action does not exist in [$1]"
fi

$2 "${@:2}"
