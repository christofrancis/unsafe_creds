+====================================================================+
|                  UNSAFE CREDS - EDUCATIONAL PROJECT                |
+====================================================================+

Unsafe Creds is a small educational PHP project for learning basic
web application, HTTP request, local networking, logging, and
cybersecurity concepts.

The project starts PHP's built-in development server and serves a
simple login form inside a local lab environment.


+--------------------------------------------------------------------+
| IMPORTANT NOTICE                                                   |
+--------------------------------------------------------------------+

THIS PROJECT IS INTENDED ONLY FOR EDUCATIONAL AND TESTING PURPOSES.

Never enter real usernames, passwords, email addresses, account
credentials, or any other sensitive information.

Always use fake test credentials.

Submitted test values are stored locally in plain text and may appear
in:

   data/submits.txt
   data/server.log

Do not use this project to collect credentials or personal data from
other people.

Only run it on systems and networks that you own or have explicit
permission to use.

PHP's built-in server is intended for development and testing.

Do not use this project as a production server or expose it directly
to the public Internet.


+--------------------------------------------------------------------+
| PROJECT FILES                                                      |
+--------------------------------------------------------------------+

Shared application files:

   favicon.ico
   index.html
   index.php
   router.php


Platform launchers:

   start_LINUX.sh
   start_WINDOWS.bat
   start_ANDROID.sh
   start_MACOS.sh


Platform instructions:

   ReadMe_LINUX.txt
   ReadMe_WINDOWS.txt
   ReadMe_ANDROID.txt
   ReadMe_MACOS.txt


Repository configuration:

   .gitignore


+--------------------------------------------------------------------+
| GENERATED DATA                                                     |
+--------------------------------------------------------------------+

The project automatically creates:

   data/

This directory may contain:

   data/config.env
   data/server.log
   data/submits.txt

These files do not need to exist in the GitHub repository.

The recommended .gitignore excludes:

   data/
   .venv/

The current project does not require Python or a Python virtual
environment.


+--------------------------------------------------------------------+
| HOW THE PROJECT WORKS                                              |
+--------------------------------------------------------------------+

1. A platform-specific launcher creates the data directory.

2. The launcher asks for an IP address and port.

3. PHP starts on:

   0.0.0.0

   using the selected port.

4. router.php handles routing and request logging.

5. index.html displays the educational login form.

6. index.php stores submitted TEST values in:

   data/submits.txt

7. Server activity is written to:

   data/server.log


The router log may include:

   - client IP address
   - operating system
   - browser
   - HTTP method
   - requested URI


+--------------------------------------------------------------------+
| DEFAULT SETTINGS                                                   |
+--------------------------------------------------------------------+

Default values:

   IP:   127.0.0.1
   PORT: 8000


127.0.0.1 is used when the browser and PHP server are running on the
same device.

To connect from another device on the same local network, use the
actual local IPv4 address of the computer or phone running the server.

Example:

   http://192.168.1.100:8000/index.html


+--------------------------------------------------------------------+
| PLATFORM INSTRUCTIONS                                              |
+--------------------------------------------------------------------+

Linux:

   ReadMe_LINUX.txt


Windows:

   ReadMe_WINDOWS.txt


Android / Termux:

   ReadMe_ANDROID.txt


macOS:

   ReadMe_MACOS.txt


Follow the instruction file for your operating system before starting
the project.


+--------------------------------------------------------------------+
| DISCLAIMER                                                         |
+--------------------------------------------------------------------+

This software is provided for educational purposes only.

The project is intended to demonstrate:

   - PHP development servers
   - HTTP requests
   - form handling
   - client/server communication
   - local networking
   - request logging
   - basic cybersecurity awareness


The author does not authorize use of this project for credential
theft, phishing, unauthorized monitoring, impersonation, or collection
of personal information.

Users are responsible for ensuring that their use of this project
complies with applicable laws, institutional rules, network policies,
and consent requirements.

Use only fake test credentials.

Use responsibly.

Use only in controlled environments.


+====================================================================+
|                              END                                   |
+====================================================================+
