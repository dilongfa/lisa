#!/bin/bash

devtool() {
    apt-get install curl git apt-transport-https lsb-release build-essential libssl-dev
}

nginx() {
    apt-get install nginx
}

nodejs() {
    curl --silent --location https://deb.nodesource.com/setup_11.x | sudo bash -
    apt-get install nodejs
}
