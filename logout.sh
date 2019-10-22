#!/bin/bash
# Version : 2.0
# Description : This bash script is used to logout to NITC network without any browser. Can be used in Linux systems in robots, where no display is connected such as Raspberry Pi...etc, This has to be used in conjuction with login.sh script

#stores current directory value
CURRENT_DIR=$(dirname "${BASH_SOURCE[0]}")

# reading file using sed command
web_address=$(cat $CURRENT_DIR/log_file | sed -n '1p')
secure_key=$(cat $CURRENT_DIR/log_file | sed -n '2p')

#long form of request
#curl 'http://192.168.102.1:1000/logout?0d080d000a135b5c' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: http://192.168.102.1:1000/keepalive?0d080d000a135b5c' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' --compressed

#reduced form of request
checkoutput=$(curl -s --connect-timeout 3.0 "$web_address/logout?$secure_key" -H "Referer: $web_address/keepalive?$secure_key" --compressed)

if [ "$checkoutput" == "" ]; then
    echo "Something is not right please check the log_file." 
    echo "If the IP address is not correct, either change it to correct one or rerun login.sh script"
else 
    echo "Logout Successful"
fi