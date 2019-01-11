
error() {
    echo -e "\033[1;31m$1\033[0m"; exit 1
}

success() {
    echo -e "\033[1;32m$1\033[0m"; exit 1
}

info() {
    echo -e "\033[1;36m$1\033[0m"; exit 1
}

sudo() {
    if [[ $(id -u) != 0 ]]; then
        error "Require root permission or sudo for this command"
    fi
}

