
install() {
    sudo
    apt-get update
    apt-get install dnsmasq
}

uninstall() {
    apt-get purge dnsmasq
}

config() {
    mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
    cp $DIR/configs/dnsmasq/dnsmasq.conf /etc/dnsmasq
}

