@echo off
title Operation CHARM - ngrok Setup
color 0A

echo ========================================
echo   Operation CHARM - ngrok Setup
echo ========================================
echo.

echo [STEP 1] Installing ngrok...
echo Go to https://ngrok.com and sign up for free
echo Download ngrok and extract to C:\ngrok\
echo.
pause

echo [STEP 2] Authenticate ngrok...
echo Enter your ngrok authtoken (from your dashboard):
set /p AUTHTOKEN=Authtoken: 
C:\ngrok\ngrok authtoken %AUTHTOKEN%

echo.
echo [STEP 3] Starting Operation CHARM server...
start "Operation CHARM Server" cmd /c "cd /d I:\operation-charm && Simple-CHARM-Launcher.bat"

echo.
echo [STEP 4] Waiting for server to start...
timeout /t 15

echo.
echo [STEP 5] Starting ngrok tunnel...
echo Your website will be available at a public URL
C:\ngrok\ngrok http 8080

echo.
echo Server and tunnel stopped. Press any key to exit.
pause
