@echo off
title Operation CHARM - Car Service Manuals
echo ========================================
echo   Operation CHARM - Starting Server
echo ========================================
echo.

cd /d "I:\operation-charm"

echo Checking if server is already running...
wsl -e bash -c "pgrep -f 'node server.js' && echo 'Server already running on http://localhost:8080' && exit 0 || echo 'No existing server found, starting new instance...'"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Server is already running!
    echo Access your car manuals at: http://localhost:8080
    echo.
    pause
    exit /b 0
)

echo.
echo Starting Operation CHARM server...
echo This will open your car service manual database
echo.
echo Please wait while the server initializes...
echo.

wsl -e bash -c "cd /mnt/i/operation-charm && echo 'Mounting database if needed...' && sudo mount -o loop -t squashfs ./lmdb-pages.sqsh ./lmdb-pages 2>/dev/null || echo 'Database already mounted' && echo 'Starting server...' && sudo node server.js / 8080"

echo.
echo Server has stopped. Press any key to close this window.
pause >nul
