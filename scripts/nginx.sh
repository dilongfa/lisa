#!/bin/bash

VHOST_DIR="/etc/nginx/conf.d"
PROJECT_DIR=$HOME"/projects"

create() {
cat <<EOF > "$VHOST_DIR/$1"
server
{
    listen          80;
    server_name     www.$1;
    access_log      off;
    log_not_found   off;
    return          301 \$scheme://$1\$request_uri;
}
EOF
}

modify() {
    nano $VHOST_DIR/$1
}

remove() {
    local domain="$1"
    
    if [ -e "$VHOST_DIR/$domain" ]; then
        rm $VHOST_DIR/$domain
    fi

}

restart() {
    sudo systemctl restart nginx
}
