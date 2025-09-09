@echo off
title pistn.ai - Operation CHARM Website
color 0A

echo ========================================
echo   pistn.ai - Operation CHARM Website  
echo ========================================
echo.

echo [INFO] Starting your professional website at https://pistn.ai
echo [INFO] Make sure you've completed the domain setup first!
echo.

echo [STEP 1] Starting Operation CHARM server...
start "Operation CHARM Server" cmd /c "cd /d I:\operation-charm && Simple-CHARM-Launcher.bat"

echo.
echo [STEP 2] Waiting for server to initialize...
timeout /t 15

echo.
echo [STEP 3] Starting Cloudflare Tunnel...
echo [INFO] Your website will be live at: https://pistn.ai
echo [INFO] Press Ctrl+C to stop both services
echo.

cloudflared tunnel run pistn-ai

echo.
echo [INFO] Website stopped. Press any key to exit.
pause
