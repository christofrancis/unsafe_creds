+====================================================================+
|              UNSAFE CREDS - ANDROID / TERMUX SETUP                |
+====================================================================+

The Android version uses Termux and the launcher:

   start_ANDROID.sh

Root access is not required.

For the most complete Termux experience, use a current stable Termux
build from F-Droid or the official Termux GitHub releases. The Google
Play build is maintained separately and may differ in functionality.


+--------------------------------------------------------------------+
| 1. UPDATE TERMUX                                                   |
+--------------------------------------------------------------------+

Open Termux and run:

   pkg update

Optional:

   pkg upgrade


+--------------------------------------------------------------------+
| 2. INSTALL PHP AND GIT                                             |
+--------------------------------------------------------------------+

Run:

   pkg install php git

Verify:

   php -v
   git --version


+--------------------------------------------------------------------+
| 3. DOWNLOAD THE PROJECT                                            |
+--------------------------------------------------------------------+

Cloning the repository directly into the Termux home directory is the
simplest option:

   git clone YOUR_GITHUB_REPOSITORY_URL

Enter the project directory:

   cd unsafe_creds

Replace the directory name if your repository uses a different name.


+--------------------------------------------------------------------+
| 4. MAKE THE LAUNCHER EXECUTABLE                                    |
+--------------------------------------------------------------------+

Run:

   chmod +x start_ANDROID.sh


+--------------------------------------------------------------------+
| 5. START THE PROJECT                                               |
+--------------------------------------------------------------------+

Run:

   ./start_ANDROID.sh

For testing on the same smartphone, press Enter to keep:

   IP:   127.0.0.1
   PORT: 8000

The script will try to open:

   http://127.0.0.1:8000/index.html

If the browser does not open automatically, open that address manually.


+--------------------------------------------------------------------+
| STOP THE SERVER                                                    |
+--------------------------------------------------------------------+

Return to Termux and press:

   Ctrl + C


+--------------------------------------------------------------------+
| TROUBLESHOOTING                                                    |
+--------------------------------------------------------------------+

PHP not found:

   pkg install php

Git not found:

   pkg install git

Permission denied when running the launcher:

   chmod +x start_ANDROID.sh

Port 8000 is already in use:

   Restart the launcher and choose another port, for example 8080.

+====================================================================+
|                              END                                   |
+====================================================================+
