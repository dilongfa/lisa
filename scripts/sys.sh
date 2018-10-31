#!/bin/bash

set_timezone() {
    sudo dpkg-reconfigure tzdata
    #local TZ="Asia/Ho_Chi_Minh"
    #timedatectl set-timezone $TZ
    #success "Timezone $TZ is setup completed" 
}


