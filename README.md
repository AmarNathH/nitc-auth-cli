# Nitc-auth-CLI


[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)

These scripts can be used for logging in and loggin out from NITC Network in the CLI itself, without any need for GUI. These can be used in headless systems such as Servers, Raspberry-pi..etc. It has been made sure that the script uses only bare-minimum external programs which is commonly available in any minimal Linux-based systems.

| Code | Description |
|------|:------|
| `login.sh` | This script will prompt the user for username and password, and will give appropriate status feedback for login. |
| `logout.sh` | This script is responsible for logging you out of the network, you can run this once your work is over. |
| `log_file` | This file stores the information about current sessions 16-digit key as well as the details of the network, this is used by the logout script.|
