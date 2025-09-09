@echo off
title Operation CHARM - New PC Setup
color 0B

echo ========================================
echo   Operation CHARM - New PC Setup
echo ========================================
echo.

echo [INFO] This script will set up Operation CHARM on a new PC
echo [INFO] Make sure your external drive is connected!
echo.

echo [STEP 1] Detecting current drive...
cd /d %~dp0
echo Current location: %CD%
echo.

echo [STEP 2] Checking for required files...
if not exist "lmdb-pages.sqsh" (
    echo ERROR: lmdb-pages.sqsh not found!
    echo Make sure you're running this from the correct drive
    pause
    exit /b 1
)

if not exist "lmdb-images" (
    echo ERROR: lmdb-images folder not found!
    pause
    exit /b 1
)

echo ✓ Database files found
echo.

echo [STEP 3] Installing WSL (if needed)...
wsl --status >nul 2>&1
if errorlevel 1 (
    echo Installing WSL2...
    wsl --install
    echo.
    echo [IMPORTANT] WSL installation requires a restart!
    echo Please restart your PC and run this script again.
    pause
    exit /b 0
)

echo ✓ WSL is available
echo.

echo [STEP 4] Cloning repository...
if not exist "operation-charm" (
    git clone https://github.com/ryaghi23/pistn-ai.git operation-charm
    echo ✓ Repository cloned
) else (
    echo ✓ Repository already exists
)

echo.
echo [STEP 5] Setting up WSL environment...
wsl -e bash -c "cd '%CD%/operation-charm' && echo 'Installing Node.js and dependencies...' && sudo apt update && sudo apt install -y nodejs npm build-essential python3 && npm install"

echo.
echo [STEP 6] Creating launcher...
copy /y operation-charm\Simple-CHARM-Launcher.bat "%CD%\Start-Operation-CHARM.bat"

echo.
echo [SUCCESS] Setup complete!
echo.
echo [NEXT STEPS]
echo 1. Run: Start-Operation-CHARM.bat
echo 2. Your website will be available at: http://localhost:8080
echo 3. For public access, set up Cloudflare Tunnel as before
echo.
echo Press any key to start Operation CHARM now...
pause

Start-Operation-CHARM.bat
