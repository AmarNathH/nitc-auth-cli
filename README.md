# Nitc-auth-CLI
These scripts can be used for logging in and loggin out from NITC Network in the CLI itself, without any need for GUI. These can be used in headless systems such as Servers, Raspberry-pi..etc. It has been made sure that the script uses only bare-minimum external programs which is commonly available in any minimal Linux-based systems.

| Code | Description |
|------|:------|
| `login.sh` | This script will prompt the user for username and password, and will give appropriate status feedback for login. |
| `logout.sh` | This script is responsible for logging you out of the network, you can run this once your work is over. |
| `log_file` | This file stores the information about current sessions 16-digit key as well as the details of the network, this is used by the logout script.|
