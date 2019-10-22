#!/bin/bash
# Version : 2.0
# Description : This bash script is used to login to NITC network without any browser. Can be used in Linux systems in robots, servers...etc, where no display is connected such as Raspberry Pi...etc, make sure you have logout.sh script also which can be used to logout later

output=$(curl -m 3 -s 'http://www.gstatic.com/generate_204'--compressed)

# variable used to check whether we are already logged in or not
checkoutput=${output:0:6}

if [ "$checkoutput" != '<html>' ]; then
    echo "Something doesn't seem right. Check if you are already logged in"
    exit
fi

# reading username and password to be used from user, the password will be hidden while typing
read -p 'Username: ' username

# using printf to hide the typing of the password
printf "Password: "
read -s password
printf "\n"


# Extracting the web address and the secure key used, is later used to logout
# curl writes to stderr, but grep works with stdout, hence the below redirection is necessary
web_address=$(curl -m 3 -s 'http://www.gstatic.com/generate_204' -H 'Upgrade-Insecure-Requests: 1' --compressed 2>&1 | sed -e 's/.*href="\(.*\)fg.*/\1/' )
secure_key=$(curl -m 3 -s 'http://www.gstatic.com/generate_204' -H 'Upgrade-Insecure-Requests: 1' --compressed 2>&1 | sed -e 's/.*?\(.*\)">.*/\1/')

# We have to connect to the website once so that the subsequent curl requests work; /dev/null to suppress output
curl -s -m 3 "${web_address}fgtauth?${secure_key}" > /dev/null

#stores current directory value
CURRENT_DIR=$(dirname "${BASH_SOURCE[0]}")

#this stores the current key value and the web address to a file, this file is used by logout script later for logging out.
echo "$web_address" > $CURRENT_DIR/log_file
echo "$secure_key" >> $CURRENT_DIR/log_file

# command for send packet with specified username and password
curl_cmd="curl -s -m 3 '${web_address}' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Origin: ${web_address}' -H 'Upgrade-Insecure-Requests: 1' -H 'Referer: ${web_address}fgtauth?${secure_key}' --data '4Tredir=http%3A%2F%2Fwww.gstatic.com%2Fgenerate_204&magic=${secure_key}&username=${username}&password=${password}' --compressed"

checkoutput=$(eval $curl_cmd)

if [ "$checkoutput" = "" ]; then
    echo "Not able to connect to the website."
    echo "If it is not your internet, then raise this issue at Github."
    exit
fi

#extract status from the output of curl
checkoutput=$(echo "$checkoutput" | sed -n "75p")

if [ "$checkoutput" = "" ]; then
    echo "Firewall Authentication Successful"
else
    echo $checkoutput
fi
