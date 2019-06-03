# Nitc-auth-CLI


![platform-Linux](https://img.shields.io/badge/Platform-Linux-orange.svg) [![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/) 
[![MIT License](https://img.shields.io/github/license/AmarNathH/nitc-auth-cli.svg?label=License)](http://perso.crans.org/besson/LICENSE.html)

These scripts can be used for logging in and out of NITC Network from the CLI itself, without any need for GUI. It has been made sure that the script uses only bare-minimum external programs which is commonly available in any minimal Linux-based systems, so that it can be used in various headless systems such as Servers, Raspberry-pi..etc.

| File | Description |
|------|:------|
| `login.sh` | This script will prompt the user for username and password, and will give appropriate status feedback for logging into the network. |
| `logout.sh` | This script is responsible for logging you out, it will logout from the network and give appropriate feedback for logout. It is highly recommended to use this script with the login script only. |
| `log_file` | This file will be generated by login.sh. This file stores the information about current session's key as well as the details of the network, this is used by the logout script.|

**Dependencies:** wget, curl, sed

Make sure you have the dependencies before using the script

You can use the files directly as `./login.sh` and `./logout.sh` or you could install them. You can install the files to your system by using the `install.sh` script. Please run it with `sudo ./install.sh`. The installation will install the files to the `/opt/nitc-auth-cli/` directory and will add aliases for the `login.sh`,`logout.sh` and `log_file`. You can then execute the login script by using the command `nitc-login`, logout script by using the command `nitc-logout` and you can see the content inside `log_file` with the command `nitc-logfile`. As of now the install script supports bash and zsh shells.

 If you are not able run the scripts, you can use the command
 
`chmod +x <script-name>.sh`

This will change the permission of the script files, and will allow you to run the scripts
