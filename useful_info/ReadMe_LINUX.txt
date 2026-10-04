+====================================================================+
|                    UNSAFE CREDS - LINUX SETUP                      |
+====================================================================+

These instructions are intended for Linux systems such as Kali Linux,
Debian, Ubuntu, and similar distributions.


+--------------------------------------------------------------------+
| 1. INSTALL PHP                                                     |
+--------------------------------------------------------------------+

On Debian/Kali-based systems:

   sudo apt update
   sudo apt install php

Verify:

   php -v


+--------------------------------------------------------------------+
| 2. DOWNLOAD THE PROJECT                                            |
+--------------------------------------------------------------------+

Clone the repository or download and extract the ZIP archive.

Open a terminal inside the project directory.

Example:

   cd unsafe_creds


+--------------------------------------------------------------------+
| 3. MAKE THE LAUNCHER EXECUTABLE                                    |
+--------------------------------------------------------------------+

Run:

   chmod +x start_LINUX.sh

This normally needs to be done only once.


+--------------------------------------------------------------------+
| 4. START THE PROJECT                                               |
+--------------------------------------------------------------------+

Run:

   ./start_LINUX.sh

For testing on the same computer, press Enter to keep:

   IP:   127.0.0.1
   PORT: 8000

The browser should open automatically. If it does not, open the URL
printed in the terminal manually.


+--------------------------------------------------------------------+
| ACCESS FROM ANOTHER DEVICE                                         |
+--------------------------------------------------------------------+

Find the Linux computer's local IPv4 address:

   hostname -I

or:

   ip addr

Restart the launcher and enter the local address instead of 127.0.0.1.

Example:

   Enter IP address [127.0.0.1]: 192.168.1.100

Then open on another device connected to the same local network:

   http://192.168.1.100:8000/index.html

Do not use 127.0.0.1 from another device. On every device, 127.0.0.1
always means that device itself.


+--------------------------------------------------------------------+
| STOP THE SERVER                                                    |
+--------------------------------------------------------------------+

Return to the terminal running the project and press:

   Ctrl + C


+--------------------------------------------------------------------+
| TROUBLESHOOTING                                                    |
+--------------------------------------------------------------------+

PHP not found:

   sudo apt install php

Port 8000 is already in use:

   Restart the launcher and choose another port, for example 8080.

The page works locally but not from another device:

   - use the computer's actual local IPv4 address
   - make sure both devices can communicate on the same local network
   - check the Linux firewall if one is enabled

+====================================================================+
|                              END                                   |
+====================================================================+
