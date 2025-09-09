@echo off
title Operation CHARM - Portable Launcher
color 0A

echo ========================================
echo   Operation CHARM - Portable Launcher
echo ========================================
echo.

echo [INFO] Auto-detecting drive and starting server...
echo.

cd /d %~dp0

echo [STEP 1] Checking files...
if not exist "lmdb-pages.sqsh" (
    echo ERROR: Database files not found in current directory
    echo Make sure you're running from the correct location
    pause
    exit /b 1
)

echo ✓ Database files found at: %CD%
echo.

echo [STEP 2] Starting Operation CHARM server...
echo [INFO] Server will be available at: http://localhost:8080
echo [INFO] Browser will open automatically when ready
echo [INFO] Press Ctrl+C to stop the server
echo.

start "Operation CHARM Server" wsl -e bash -c "cd '%CD%/operation-charm' && echo 'Mounting database...' && sudo mount -o loop -t squashfs ../lmdb-pages.sqsh ./lmdb-pages 2>/dev/null || echo 'Database already mounted' && echo 'Starting server...' && sudo node server.js / 8080"

echo [STEP 3] Waiting for server to start...
timeout /t 8

echo [STEP 4] Opening website in browser...
start http://localhost:8080

echo.
echo [SUCCESS] Operation CHARM is now running!
echo [INFO] Website opened at: http://localhost:8080
echo [INFO] Close the server window to stop the application
echo.
pause

echo.
echo Server stopped. Press any key to exit.
pause
