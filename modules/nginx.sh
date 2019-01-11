
install() {
    apt-get update
    apt-get install nginx
}

create() {
cat <<EOF > "$NGINX_VHOST_DIR/$1"
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
    nano $NGINX_VHOST_DIR/$1
}

remove() {
    local hostname="$1"
    if [ -e "$NGINX_VHOST_DIR/$hostname" ]; then
        rm $NGINX_VHOST_DIR/$hostname
    fi

}

restart() {
    systemctl restart nginx
}

stop() {
    systemctl stop nginx
}

start() {
    systemctl start nginx
}
