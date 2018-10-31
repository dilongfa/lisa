#!/bin/bash

LS_DIR=$(dirname $(readlink -f $0))

sudo unlink /usr/local/bin/lisa
sudo chmod -x $LS_DIR/lisa.sh

echo "LISA has been removed"