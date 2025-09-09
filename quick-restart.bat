@echo off
title Quick Restart - pistn.ai
color 0A

echo ========================================
echo   Quick Restart - pistn.ai
echo ========================================
echo.

echo [INFO] Restarting website with latest changes...

echo.
echo [STEP 1] Stopping services...
taskkill /f /im node.exe 2>nul
taskkill /f /im cloudflared.exe 2>nul

echo.
echo [STEP 2] Restarting website...
start "pistn.ai Website" cmd /c "start-pistn-ai-website.bat"

echo.
echo [SUCCESS] Website restarted!
echo [INFO] Your updates are now live at: https://pistn.ai
echo.
pause
