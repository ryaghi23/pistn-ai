@echo off
title Setup Cloudflare Tunnel for Operation CHARM
color 0B

echo ========================================
echo   Cloudflare Tunnel Setup
echo ========================================
echo.

echo [STEP 1] Installing Cloudflare Tunnel...
winget install --id Cloudflare.cloudflared

echo.
echo [STEP 2] Login to Cloudflare...
echo This will open your browser to authenticate
pause
cloudflared tunnel login

echo.
echo [STEP 3] Creating tunnel...
cloudflared tunnel create operation-charm

echo.
echo [STEP 4] Creating DNS record...
echo Enter your domain name (or press Enter to skip for now):
set /p DOMAIN=Domain: 
if not "%DOMAIN%"=="" (
    cloudflared tunnel route dns operation-charm %DOMAIN%
)

echo.
echo [INFO] To start the tunnel, run:
echo cloudflared tunnel --url http://localhost:8080 run operation-charm
echo.
echo [INFO] Or use the combined launcher we'll create...
pause
