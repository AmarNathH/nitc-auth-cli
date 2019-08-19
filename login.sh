#!/bin/bash
# Version : 2.0
# Author : Amarnath (amarnath.h.96@gmail.com)
# Description : This bash script is used to login to NITC network without any browser. Can be used in Linux systems in robots, where no display is connected such as Raspberry Pi...etc, make sure you have logout.sh script also which can be used to logout later

output=$(curl -s 'http://www.gstatic.com/generate_204'--compressed)

# variable used to check whether we are already logged in or not
checkoutput=${output:0:6}

if [ "$checkoutput" != '<html>' ]; then
    echo "Something doesn't seem right. Check if you are already logged in"
    exit
fi

# Extracting the web address and the secure key used, is later used to logout
# curl writes to stderr, but grep works with stdout, hence the below redirection is necessary
web_address=$(curl -s 'http://www.gstatic.com/generate_204'--compressed 2>&1 | sed -e 's/.*href="\(.*\)fg.*/\1/' )
secure_key=$(curl -s 'http://www.gstatic.com/generate_204'--compressed 2>&1 | sed -e 's/.*?\(.*\)">.*/\1/' )

# reading username and password to be used from user, the password will be hidden while typing
read -p 'Username: ' username

# using printf to hide the typing of the password
printf "Password: "
read -s password
printf "\n"

#stores current directory value
CURRENT_DIR=$(dirname "${BASH_SOURCE[0]}")

#this stores the current key value and the web address to a file, this file is used by logout script later for logging out.
echo "$web_address" > $CURRENT_DIR/log_file
echo "$secure_key" >> $CURRENT_DIR/log_file

#long form of the request
# curl "${web_address}" -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H "Origin: $web_address" -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H "Referer: $web_address/fgtauth?$secure_key" -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' --data "4Tredir=http%3A%2F%2Fwww.gstatic.com%2Fgenerate_204&magic=$secure_key&username=$username&password=$password" --compressed

#reduced form of the request
checkoutput=$(curl -s "${web_address}" -H 'Connection: keep-alive' -H "Origin: $web_address" -H "Referer: $web_address fgtauth?$secure_key" --data "4Tredir=http%3A%2F%2Fwww.gstatic.com%2Fgenerate_204&magic=$secure_key&username=$username&password=$password" --compressed)

#extract status from the output of curl
checkoutput=$(echo "$checkoutput" | sed -n "75p")

if [ "$checkoutput" = "" ]; then
    echo "Firewall Authentication Successful"
else
    echo $checkoutput
fi
