+====================================================================+
|                   UNSAFE CREDS - WINDOWS SETUP                     |
+====================================================================+

The Windows launcher is:

   start_WINDOWS.bat

Windows PowerShell is used internally by the launcher to display PHP
output and save the same output to data\server.log.


+--------------------------------------------------------------------+
| 1. INSTALL PHP                                                     |
+--------------------------------------------------------------------+

Download a current PHP build for Windows from the official PHP
website.

For a typical modern 64-bit Windows computer and command-line use, an
x64 Non-Thread-Safe (NTS) build is appropriate.

Extract PHP to a permanent directory, for example:

   C:\php

The directory should contain php.exe.

PHP for Windows also requires the Microsoft Visual C++ runtime. If PHP
reports a missing runtime or DLL, install the current Visual C++
Redistributable supported by PHP.


+--------------------------------------------------------------------+
| 2. ADD PHP TO PATH                                                 |
+--------------------------------------------------------------------+

Add the directory containing php.exe to the existing Windows PATH.
Do not replace the existing PATH value.

Example directory:

   C:\php

Close and reopen Command Prompt, then verify:

   php -v

If Windows reports that php is not recognized, the PHP directory is
not available in PATH yet.


+--------------------------------------------------------------------+
| 3. DOWNLOAD THE PROJECT                                            |
+--------------------------------------------------------------------+

Clone the repository or download and extract the ZIP archive.

Open the project directory.


+--------------------------------------------------------------------+
| 4. START THE PROJECT                                               |
+--------------------------------------------------------------------+

Double-click:

   start_WINDOWS.bat

or open Command Prompt in the project directory and run:

   start_WINDOWS.bat

For testing on the same computer, press Enter to keep:

   IP:   127.0.0.1
   PORT: 8000

The default browser should open automatically.


+--------------------------------------------------------------------+
| ACCESS FROM ANOTHER DEVICE                                         |
+--------------------------------------------------------------------+

Open Command Prompt and run:

   ipconfig

Find the IPv4 Address of the active Wi-Fi or Ethernet adapter.

Example:

   192.168.1.100

Restart start_WINDOWS.bat and enter that address.

Then open on another device connected to the same local network:

   http://192.168.1.100:8000/index.html

Windows Firewall may ask whether php.exe is allowed to communicate.
For local lab testing, allow it only on the appropriate trusted/private
network. Do not unnecessarily allow the development server on public
networks.


+--------------------------------------------------------------------+
| STOP THE SERVER                                                    |
+--------------------------------------------------------------------+

In the window running the server, press:

   Ctrl + C

Windows may ask:

   Terminate batch job (Y/N)?

Answer:

   Y


+--------------------------------------------------------------------+
| TROUBLESHOOTING                                                    |
+--------------------------------------------------------------------+

php is not recognized:

   Run php -v and verify that the PHP directory is included in PATH.

Port 8000 is already in use:

   Restart the launcher and select another port, for example 8080.

The page works locally but not from another device:

   - use the Windows computer's actual local IPv4 address
   - make sure both devices can communicate on the same local network
   - allow php.exe through Windows Firewall on the private network

+====================================================================+
|                              END                                   |
+====================================================================+
