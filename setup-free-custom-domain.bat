@echo off
title Operation CHARM - Free Custom Domain Setup
color 0B

echo ========================================
echo   Free Custom Domain Setup
echo ========================================
echo.

echo [INFO] This setup gives you a FREE custom domain using Cloudflare
echo [COST] $0 - Completely free!
echo [RESULT] Your site at https://yourdomain.com
echo.

echo [STEP 1] Get a free domain...
echo Option A: Use Freenom.com for free domains (.tk, .ml, .ga)
echo Option B: Buy cheap domain from Namecheap ($1-10/year)
echo.
pause

echo [STEP 2] Set up Cloudflare (free account)...
echo 1. Sign up at cloudflare.com
echo 2. Add your domain
echo 3. Change nameservers at your domain provider
echo.
pause

echo [STEP 3] Install Cloudflare Tunnel...
winget install --id Cloudflare.cloudflared

echo.
echo [STEP 4] Authenticate with Cloudflare...
cloudflared tunnel login

echo.
echo [STEP 5] Create tunnel...
cloudflared tunnel create operation-charm

echo.
echo [STEP 6] Set up DNS...
echo Enter your domain name:
set /p DOMAIN=Domain (e.g., pistn-ai.com): 
cloudflared tunnel route dns operation-charm %DOMAIN%

echo.
echo [SUCCESS] Your custom domain is now set up!
echo [INFO] To start your website:
echo 1. Run your Operation CHARM server
echo 2. Run: cloudflared tunnel run operation-charm
echo.
pause
