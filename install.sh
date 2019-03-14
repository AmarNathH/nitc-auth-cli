#!/bin/bash

# Version : 1.4
# Author : Amarnath (amarnath.h.96@gmail.com)
# Description : This bash script can be used to install the nitc-auth-cli package to the system

# variables to be used in this script
INSTALL_DIR="~/.nitc-auth-cli/"
LOGIN_FILE="login.sh"
LOGOUT_FILE="logout.sh"
LOG_FILE="log_file"
SHELL=$(printenv SHELL)

#!!Check for dependencies - wget, curl and sed

echo "Checking installation files"
if [ \( ! -f "$LOGIN_FILE" \) -o \( ! -f "$LOGOUT_FILE" \) ]; then
    echo "Error: Files are not proper, please reclone the repo"
    exit
fi

if [ -d "$INSTALL_DIR" ]; then
    echo "Directory $INSTALL_DIR already exists, Overwriting!"
    rm -r "$INSTALL_DIR"
else
    echo "Installing at:$INSTALL_DIR"
fi

mkdir -p "$INSTALL_DIR"

echo "Copying Files"
cp "$LOGIN_FILE" "$INSTALL_DIR"
cp "$LOGOUT_FILE" "$INSTALL_DIR"

#Writing to bashrc and zshrc file
if [ "$SHELL" == "/usr/bin/zsh" ]; then
    echo "Writing to .zshrc file"
    echo "# nitc-auth-cli">>~/.zshrc
    echo "alias nitc-login=\"$INSTALL_DIR$LOGIN_FILE\"">>~/.zshrc
    echo "alias nitc-logout=\"$INSTALL_DIR$LOGOUT_FILE\"">>~/.zshrc
    echo "alias nitc-logfile=\"cat $INSTALL_DIR$LOG_FILE\"">>~/.zshrc
elif [ "$SHELL" == "/bin/bash" ]; then
    echo "Writing to .bashrc file"
    echo "# nitc-auth-cli">>~/.bashrc
    echo "alias nitc-login=\"$INSTALL_DIR$LOGIN_FILE\"">>~/.bashrc
    echo "alias nitc-logout=\"$INSTALL_DIR$LOGOUT_FILE\"">>~/.bashrc
    echo "alias nitc-logfile=\"cat $INSTALL_DIR$LOG_FILE\"">>~/.bashrc
fi

echo "Installation complete :)"

