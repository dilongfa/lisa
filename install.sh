#!/bin/bash

LS_DIR=$(dirname $(readlink -f $0))

sudo chmod +x $LS_DIR/lisa.sh
sudo ln -s $LS_DIR/lisa.sh /usr/local/bin/lisa
echo "LISA has been installed"
