# Operation CHARM Startup Script
# This script starts the car service manual server

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Operation CHARM - Car Service Manuals" -ForegroundColor Cyan  
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set location to project directory
Set-Location "I:\operation-charm"

# Check if server is already running
Write-Host "Checking if server is already running..." -ForegroundColor Yellow
$running = wsl -e bash -c "pgrep -f 'node server.js'"
if ($LASTEXITCODE -eq 0) {
    Write-Host "Server is already running!" -ForegroundColor Green
    Write-Host "Access your car manuals at: http://localhost:8080" -ForegroundColor Green
    Write-Host ""
    Write-Host "Press any key to open in browser or close this window..." -ForegroundColor White
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Start-Process "http://localhost:8080"
    exit 0
}

Write-Host "Starting Operation CHARM server..." -ForegroundColor Green
Write-Host "This will open your car service manual database" -ForegroundColor White
Write-Host ""
Write-Host "Please wait while the server initializes..." -ForegroundColor Yellow
Write-Host ""

# Start the server
try {
    Write-Host "Mounting database if needed..." -ForegroundColor Yellow
    wsl -e bash -c "cd /mnt/i/operation-charm && sudo mount -o loop -t squashfs ./lmdb-pages.sqsh ./lmdb-pages 2>/dev/null || echo 'Database already mounted'"
    
    Write-Host "Starting server on http://localhost:8080..." -ForegroundColor Green
    wsl -e bash -c "cd /mnt/i/operation-charm && echo 'rabih123' | sudo -S node server.js / 8080"
}
catch {
    Write-Host "Error starting server: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "Server has stopped. Press any key to close this window." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
