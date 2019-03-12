#!/bin/bash

# Version : 1.4
# Author : Amarnath (amarnath.h.96@gmail.com)
# Description : This bash script can be used to login to NITC network without any browser. Can be used in Linux systems in robots, where no display is connected such as Raspberry Pi...etc, make sure you have logout.sh script also which can be used to logout later

# reading username and password to be used from user, the password will be hidden while typing
output=$(curl -s 'http://www.gstatic.com/generate_204'--compressed)

checkoutput=${output:0:6}

if [ "$checkoutput" != '<html>' ]; then
    echo "Something doesn't seem right. Check if you are already logged in"
    exit
fi

read -p 'Username: ' username
printf "Password: "
read -s password
printf "\n"

web_address=${output:105:25}
# web_address=$(echo $output | cut -c106-130)

output="`wget -qO- www.gstatic.com`"
secure_key=${output:1758:16}
# secure_key=$(echo $output | cut -c140-155)

#this stores the current key value and the web address to a file, this file is used by logout script later for logging out.
echo $web_address > log_file
echo $secure_key >> log_file


#long form
# curl "${web_address}" -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H "Origin: $web_address" -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H "Referer: $web_address/fgtauth?$secure_key" -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' --data "4Tredir=http%3A%2F%2Fwww.gstatic.com%2Fgenerate_204&magic=$secure_key&username=$username&password=$password" --compressed

#reduced form
checkoutput=$(curl -s "${web_address}" -H 'Connection: keep-alive' -H "Origin: $web_address" -H "Referer: $web_address/fgtauth?$secure_key" --data "4Tredir=http%3A%2F%2Fwww.gstatic.com%2Fgenerate_204&magic=$secure_key&username=$username&password=$password" --compressed)

#extract status from the output of curl
checkoutput=$(echo "$checkoutput" | sed -n "75p")

if [ "$checkoutput" = "" ]; then
    echo "Firewall Authentication Successful"
else
    echo $checkoutput
fi