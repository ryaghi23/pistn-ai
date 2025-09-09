OPERATION CHARM - WINDOWS SETUP GUIDE
=====================================

This document outlines the complete setup process for getting Operation CHARM 
(car service manual application) running on Windows 11 with WSL.

🚀 QUICK START (If Already Set Up)
==================================
1. Double-click "Operation CHARM - Car Manuals" shortcut on your desktop
2. Wait for automatic startup (database mount + server start)
3. Access your car manuals at: http://localhost:8080
4. Done! 🎉

If the shortcut doesn't exist or fails, run: Simple-CHARM-Launcher.bat

OVERVIEW
--------
Operation CHARM is a Node.js web application that serves car repair manuals 
from LMDB databases. The main challenge is that it requires mounting a 59GB 
squashfs file, which Windows cannot handle natively.

PREREQUISITES
-------------
- Windows 11 with WSL2 installed
- Node.js v22+ installed on Windows (for development)
- Ubuntu 22.04 LTS in WSL
- Administrative privileges
- Password for sudo operations in WSL

INITIAL PROJECT STATE
--------------------
- Project located at: I:\operation-charm
- Main database: lmdb-pages.sqsh (59GB compressed squashfs file)
- Images database: lmdb-images/data.mdb (697GB)
- Node.js server: server.js (Express application)
- Dependencies: package.json with custom node-lmdb patch

SETUP PROCESS
=============

STEP 1: WSL Environment Setup
-----------------------------
1. Install Node.js and npm in WSL:
   ```bash
   sudo apt update
   sudo apt install -y nodejs npm build-essential python3
   ```
   Result: Node.js v12.22.9 and npm v8.5.1 installed

STEP 2: Mount Squashfs Database
-------------------------------
1. Create mount directory:
   ```bash
   mkdir -p /mnt/i/operation-charm/lmdb-pages
   ```

2. Mount the squashfs file:
   ```bash
   sudo mount -o loop -t squashfs /mnt/i/operation-charm/lmdb-pages.sqsh /mnt/i/operation-charm/lmdb-pages
   ```
   
   Note: This creates a READ-ONLY filesystem mount, which caused permission issues later.

STEP 3: Install Node.js Dependencies
------------------------------------
1. Navigate to project directory in WSL:
   ```bash
   cd /mnt/i/operation-charm
   ```

2. Remove Windows-compiled node_modules (had invalid ELF headers for Linux):
   ```bash
   rm -rf node_modules
   ```

3. Install dependencies for Linux:
   ```bash
   npm install
   ```
   
   This rebuilds the native node-lmdb module for Linux compatibility.

STEP 4: Fix LMDB Configuration Issues
-------------------------------------
The main issue was "Permission denied" errors when LMDB tried to access the 
read-only squashfs filesystem. 

1. Modified server.js LMDB configuration (lines 37-45):
   ```javascript
   env.open({
       path,
       mapSize: 2 * 1024**4,
       readOnly: true,
       unsafeNoLock: true,
       noSubdir: false,
       noSync: true,
       noMetaSync: true,
   });
   ```
   
   Added noSync and noMetaSync options to prevent write operations.

STEP 5: Resolve Permission Issues
---------------------------------
Even with read-only configuration, permission errors persisted. The solution 
was to run the server with elevated privileges:

```bash
sudo node server.js / 8080
```

ROOT CAUSE ANALYSIS
==================
The permission issues occurred because:
1. Squashfs filesystems are inherently read-only
2. LMDB still attempts to create lock files even in read-only mode
3. The WSL user account didn't have sufficient permissions to access mounted filesystems
4. Running with sudo provided the necessary system-level access

FINAL WORKING COMMAND
====================
```bash
cd /mnt/i/operation-charm
sudo node server.js / 8080
```

DESKTOP SHORTCUT & LAUNCHERS
============================
For easy access, several launcher files have been created:

1. **Desktop Shortcut**: "Operation CHARM - Car Manuals.lnk"
   - Location: Desktop
   - Double-click to start the server automatically
   - Handles all setup steps automatically

2. **Simple-CHARM-Launcher.bat** (Recommended)
   - Reliable Windows batch file
   - Checks if server is already running
   - Auto-opens browser if server exists
   - Clear step-by-step progress display
   - Automatic database mounting

3. **start-operation-charm.ps1** 
   - PowerShell version with advanced features
   - Color-coded output
   - Smart duplicate detection

4. **Operation-CHARM-Launcher.bat**
   - Basic launcher that calls PowerShell script

LAUNCHER FEATURES
================
All launchers automatically:
- Check if server is already running (prevents duplicates)
- Mount the squashfs database if needed
- Start the server with proper sudo credentials
- Display the access URL: http://localhost:8080
- Open browser automatically if server already exists
- Show clear status messages and progress

USAGE - ONE-CLICK ACCESS
=======================
1. Double-click desktop shortcut "Operation CHARM - Car Manuals"
2. Wait for automatic setup (database mount + server start)
3. Access your manuals at: http://localhost:8080

SERVER ACCESS
=============
- Local access: http://localhost:8080
- Network access: http://YOUR_LOCAL_IP:8080
- Status: Returns HTTP 200 with full HTML content
- Auto-browser opening: Supported by all launchers

TROUBLESHOOTING NOTES
====================
1. "node: command not found" - Node.js not installed in WSL
2. "invalid ELF header" - Windows-compiled native modules incompatible with Linux
3. "Permission denied" - Read-only filesystem + insufficient privileges
4. Server not responding - Process died due to unhandled errors

ALTERNATIVE APPROACHES ATTEMPTED
===============================
1. Docker approach - Failed due to Node.js version compatibility issues
2. Windows native approach - Failed due to inability to mount squashfs
3. Copying database to writable location - Interrupted due to size constraints
4. Different port numbers - Same permission issues
5. Modified file permissions - Failed on read-only filesystem

SUCCESS FACTORS
===============
1. Using WSL for Linux filesystem support
2. Rebuilding native modules for target platform
3. Proper LMDB read-only configuration
4. Running with elevated privileges (sudo)

FILES CREATED DURING SETUP
==========================
The following files were created to make Operation CHARM easy to use:

**Launcher Files:**
- Simple-CHARM-Launcher.bat (Main desktop launcher)
- start-operation-charm.ps1 (PowerShell version)
- Operation-CHARM-Launcher.bat (Basic launcher)
- create-shortcut.ps1 (Desktop shortcut creator)

**Documentation:**
- README_SETUP_GUIDE.txt (This file)

**Modified Files:**
- server.js (Updated LMDB configuration for read-only filesystems)

**Desktop Shortcut:**
- "Operation CHARM - Car Manuals.lnk" (Created on desktop)

MAINTENANCE
===========
**Easy Method (Recommended):**
- Use desktop shortcut: Double-click "Operation CHARM - Car Manuals"
- The launcher handles everything automatically

**Manual Method:**
To restart the server manually:
```bash
cd /mnt/i/operation-charm
sudo node server.js / 8080
```

To stop the server:
```bash
sudo pkill -f "node server.js"
```

To check if server is running:
```bash
wsl -e bash -c "pgrep -f 'node server.js'"
```

**Troubleshooting Launchers:**
- If desktop shortcut fails, try running Simple-CHARM-Launcher.bat directly
- If PowerShell execution policy blocks scripts, run: 
  `powershell -ExecutionPolicy Bypass -File start-operation-charm.ps1`
- All launchers are located in: I:\operation-charm\

PERFORMANCE NOTES
================
- Database size: ~756GB total (59GB + 697GB)
- Memory usage: Controlled by LMDB mapSize (2TB limit)
- Network: Serves on localhost:8080
- Response time: Fast due to local SSD access

SECURITY CONSIDERATIONS
======================
- Running with sudo provides broad system access
- Server binds to localhost only (not externally accessible by default)
- Database is read-only (no data modification possible)
- No authentication implemented (suitable for local use only)

This setup successfully provides access to the complete Operation CHARM 
database of car service manuals (1982-2013) with full search functionality,
electrical diagrams, torque specifications, and labor time estimates.
