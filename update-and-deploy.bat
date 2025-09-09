@echo off
title Update pistn.ai Website
color 0E

echo ========================================
echo   Update pistn.ai Website
echo ========================================
echo.

echo [STEP 1] Stopping current server...
taskkill /f /im node.exe 2>nul
taskkill /f /im cloudflared.exe 2>nul
echo Server stopped.

echo.
echo [STEP 2] Pushing changes to GitHub...
git add .
echo Enter commit message:
set /p COMMIT_MSG=Message: 
git commit -m "%COMMIT_MSG%"
git push origin master:main

echo.
echo [STEP 3] Restarting website...
echo Starting local server and tunnel...
start "pistn.ai Website" cmd /c "start-pistn-ai-website.bat"

echo.
echo [SUCCESS] Updates complete!
echo [INFO] Your changes are now live at: https://pistn.ai
echo [INFO] GitHub repository updated: https://github.com/ryaghi23/pistn-ai
echo.
pause
