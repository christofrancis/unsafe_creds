+====================================================================+
|                    UNSAFE CREDS - macOS SETUP                      |
+====================================================================+

The macOS launcher is:

   start_MACOS.sh


+--------------------------------------------------------------------+
| 1. INSTALL HOMEBREW                                                |
+--------------------------------------------------------------------+

If Homebrew is not installed, install it from the official website:

   https://brew.sh

After installation, verify:

   brew --version


+--------------------------------------------------------------------+
| 2. INSTALL PHP                                                     |
+--------------------------------------------------------------------+

Run:

   brew install php

Verify:

   php -v

You should see PHP version information.


+--------------------------------------------------------------------+
| 3. DOWNLOAD THE PROJECT                                            |
+--------------------------------------------------------------------+

Clone the repository or download and extract the ZIP archive.

Open Terminal and enter the project directory.

Example:

   cd unsafe_creds


+--------------------------------------------------------------------+
| 4. MAKE THE LAUNCHER EXECUTABLE                                    |
+--------------------------------------------------------------------+

Run:

   chmod +x start_MACOS.sh

This normally needs to be done only once.


+--------------------------------------------------------------------+
| 5. START THE PROJECT                                               |
+--------------------------------------------------------------------+

Run:

   ./start_MACOS.sh

For testing on the same Mac, press Enter to keep:

   IP:   127.0.0.1
   PORT: 8000

The website should automatically open in the default web browser.

If the browser does not open automatically, open:

   http://127.0.0.1:8000/index.html


+--------------------------------------------------------------------+
| ACCESS FROM ANOTHER DEVICE                                         |
+--------------------------------------------------------------------+

To access the project from another device on the same local network,
you need the Mac's local IPv4 address.

For Wi-Fi, try:

   ipconfig getifaddr en0

Example result:

   192.168.1.100

If this command returns nothing, the active network interface may use
a different name.

You can check the default network interface with:

   route -n get default | grep interface

Example:

   interface: en0

Then use:

   ipconfig getifaddr en0

Replace en0 with the interface displayed by the previous command.


Restart the project:

   ./start_MACOS.sh

Enter the local IPv4 address:

   Enter IP address [127.0.0.1]: 192.168.1.100

Keep the default port if desired:

   Enter port [8000]:

On another device connected to the same local network, open:

   http://192.168.1.100:8000/index.html


Do not use:

   127.0.0.1

from another device.

127.0.0.1 always refers to the device on which the address is used.


+--------------------------------------------------------------------+
| macOS FIREWALL                                                     |
+--------------------------------------------------------------------+

macOS may ask whether PHP is allowed to accept incoming network
connections.

If you are testing from another device on your own trusted local
network, allow the connection when required.

Do not expose the PHP development server directly to the public
Internet.


+--------------------------------------------------------------------+
| GENERATED FILES                                                    |
+--------------------------------------------------------------------+

The project automatically creates:

   data/

The directory may contain:

   data/config.env
   data/server.log
   data/submits.txt

These files do not need to be created manually.

They are excluded from Git by the project's .gitignore file.


+--------------------------------------------------------------------+
| STOP THE SERVER                                                    |
+--------------------------------------------------------------------+

Return to the Terminal window running the project and press:

   Ctrl + C

The PHP server will stop.


+--------------------------------------------------------------------+
| TROUBLESHOOTING                                                    |
+--------------------------------------------------------------------+

PROBLEM:

   php: command not found

Install PHP:

   brew install php


PROBLEM:

   brew: command not found

Install Homebrew from:

   https://brew.sh


PROBLEM:

   Permission denied when running start_MACOS.sh

Run:

   chmod +x start_MACOS.sh


PROBLEM:

   Port 8000 is already in use.

Restart the launcher and choose another port.

Example:

   8080

Then open:

   http://127.0.0.1:8080/index.html


PROBLEM:

   The website works on the Mac but not on another device.

Check:

   - use the Mac's actual local IPv4 address
   - do not use 127.0.0.1
   - make sure both devices can communicate on the same local network
   - check the macOS firewall


+--------------------------------------------------------------------+
| IMPORTANT                                                          |
+--------------------------------------------------------------------+

This project is intended only for educational and testing purposes.

PHP's built-in development server is not intended for production use.

Do not expose this project directly to the public Internet.

Always use fake test credentials.

Never enter real passwords, usernames, email accounts, or other
sensitive information.


+====================================================================+
|                              END                                   |
+====================================================================+
