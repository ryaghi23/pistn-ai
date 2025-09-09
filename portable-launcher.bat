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
echo [INFO] Press Ctrl+C to stop the server
echo.

wsl -e bash -c "cd '%CD%/operation-charm' && echo 'Mounting database...' && sudo mount -o loop -t squashfs ../lmdb-pages.sqsh ./lmdb-pages 2>/dev/null || echo 'Database already mounted' && echo 'Starting server...' && sudo node server.js / 8080"

echo.
echo Server stopped. Press any key to exit.
pause
