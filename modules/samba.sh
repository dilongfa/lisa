
# Checking root permission
sudo

install() {
    apt-get update && apt-get install samba
}

uninstall() {
    apt-get purge samba
}

config() {
    mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
    cp $DIR/configs/dnsmasq/dnsmasq.conf /etc/dnsmasq
}

