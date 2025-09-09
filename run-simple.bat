@echo off
echo ========================================
echo   Operation CHARM - Simple Startup
echo ========================================
echo.

cd /d "I:\operation-charm"

echo Checking Node.js...
node --version
if errorlevel 1 (
    echo ERROR: Node.js not found!
    pause
    exit /b 1
)

echo.
echo Installing dependencies...
npm install

echo.
echo Starting Operation CHARM server...
echo Access your website at: http://localhost:8080
echo.
echo Press Ctrl+C to stop the server
echo.

node server.js / 8080
