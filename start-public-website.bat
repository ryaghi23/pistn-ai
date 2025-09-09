@echo off
title Operation CHARM - Public Website
color 0A

echo ========================================
echo   Operation CHARM - Public Website
echo ========================================
echo.

echo [INFO] This will start your local server AND make it publicly accessible
echo [INFO] You need to have Cloudflare Tunnel set up first
echo.

echo [STEP 1] Starting local Operation CHARM server...
start "Operation CHARM Server" cmd /c "cd /d I:\operation-charm && wsl -e bash -c 'cd /mnt/i/operation-charm && echo rabih123 | sudo -S node server.js / 8080'"

echo.
echo [STEP 2] Waiting for server to start...
timeout /t 10

echo.
echo [STEP 3] Starting Cloudflare Tunnel...
echo [INFO] This will make your site publicly accessible
echo [INFO] You'll get a public URL like: https://operation-charm.yourdomain.com
echo.

cloudflared tunnel --url http://localhost:8080 run operation-charm

echo.
echo [INFO] Both services stopped. Press any key to exit.
pause
