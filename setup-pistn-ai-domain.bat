@echo off
title Operation CHARM - pistn.ai Setup
color 0B

echo ========================================
echo   Operation CHARM - pistn.ai Setup
echo ========================================
echo.

echo [INFO] Setting up your professional website at https://pistn.ai
echo [COST] $0 - Using your existing domain + free Cloudflare
echo.

echo [STEP 1] Install Cloudflare Tunnel...
echo Installing cloudflared...
winget install --id Cloudflare.cloudflared
if errorlevel 1 (
    echo ERROR: Failed to install cloudflared
    echo Please download manually from: https://github.com/cloudflare/cloudflared/releases
    pause
    exit /b 1
)

echo.
echo [STEP 2] Manual Steps Required:
echo.
echo A) Go to https://dash.cloudflare.com and create free account
echo B) Click "Add Site" and enter: pistn.ai
echo C) Choose the FREE plan
echo D) Copy the nameservers Cloudflare gives you
echo E) Go to GoDaddy and change nameservers to Cloudflare's
echo F) Wait for DNS propagation (5-60 minutes)
echo.
echo Press any key when you've completed steps A-F above...
pause

echo.
echo [STEP 3] Authenticate with Cloudflare...
echo This will open your browser for authentication
cloudflared tunnel login

echo.
echo [STEP 4] Create tunnel...
cloudflared tunnel create pistn-ai

echo.
echo [STEP 5] Set up DNS routing...
cloudflared tunnel route dns pistn-ai pistn.ai

echo.
echo [STEP 6] Create tunnel configuration...
echo Creating config file...
mkdir "%USERPROFILE%\.cloudflared" 2>nul
(
echo tunnel: pistn-ai
echo credentials-file: %USERPROFILE%\.cloudflared\[TUNNEL-ID].json
echo 
echo ingress:
echo   - hostname: pistn.ai
echo     service: http://localhost:8080
echo   - hostname: www.pistn.ai  
echo     service: http://localhost:8080
echo   - service: http_status:404
) > "%USERPROFILE%\.cloudflared\config.yml"

echo.
echo [SUCCESS] Setup complete!
echo.
echo [NEXT STEPS]
echo 1. Start your Operation CHARM server
echo 2. Run: cloudflared tunnel run pistn-ai
echo 3. Visit: https://pistn.ai
echo.
echo Your website will be live at https://pistn.ai !
pause
