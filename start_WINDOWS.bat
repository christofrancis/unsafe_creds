@echo off
setlocal EnableExtensions DisableDelayedExpansion

REM Go to the directory containing this script
cd /d "%~dp0"

set "DATA_DIR=data"
set "CONFIG_FILE=%DATA_DIR%\config.env"
set "IP=127.0.0.1"
set "PORT=8000"

if not exist "%DATA_DIR%" (
    mkdir "%DATA_DIR%"
)

REM Load previous values from config.env
if exist "%CONFIG_FILE%" (
    for /f "usebackq tokens=1,* delims==" %%A in ("%CONFIG_FILE%") do (
        if /I "%%A"=="IP" set "IP=%%B"
        if /I "%%A"=="PORT" set "PORT=%%B"
    )
)

echo ==============================
echo       SERVER CONFIGURATION
echo ==============================
echo.

set "NEW_IP="
set /p "NEW_IP=Enter IP address [%IP%]: "
if defined NEW_IP set "IP=%NEW_IP%"

set "NEW_PORT="
set /p "NEW_PORT=Enter port [%PORT%]: "
if defined NEW_PORT set "PORT=%NEW_PORT%"

REM Validate port using PowerShell and the PORT environment variable
powershell -NoProfile -Command "$p=0; if ([int]::TryParse($env:PORT,[ref]$p) -and $p -ge 1 -and $p -le 65535) { exit 0 } else { exit 1 }"

if errorlevel 1 (
    echo.
    echo ERROR: Invalid port.
    echo.
    pause
    exit /b 1
)

(
    echo IP=%IP%
    echo PORT=%PORT%
) > "%CONFIG_FILE%"

echo.
echo Using:
echo IP   = %IP%
echo PORT = %PORT%
echo.

where php >nul 2>&1

if errorlevel 1 (
    echo ERROR: PHP was not found.
    echo Make sure PHP is installed and its directory is added to PATH.
    echo.
    pause
    exit /b 1
)

if not exist "router.php" (
    echo ERROR: router.php was not found.
    echo.
    pause
    exit /b 1
)

set "WEBSITE_URL=http://%IP%:%PORT%/index.html"

echo Starting PHP server...
echo.
echo Website URL:
echo %WEBSITE_URL%
echo.

REM Open the browser after a short delay
start "" powershell -NoProfile -WindowStyle Hidden -Command "Start-Sleep -Seconds 1; Start-Process $env:WEBSITE_URL"

REM Run PHP in the current window and save the same output to data\server.log
powershell -NoProfile -Command "& php -S ('0.0.0.0:' + $env:PORT) router.php 2>&1 | ForEach-Object { $_.ToString(); $_.ToString() | Out-File -FilePath (Join-Path $env:DATA_DIR 'server.log') -Append -Encoding utf8 }"

echo.
echo Server stopped.
echo.

pause

endlocal
