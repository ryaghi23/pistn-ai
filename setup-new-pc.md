# Operation CHARM - New PC Setup Guide

## Prerequisites for New PC

### Required Software:
1. **Windows 10/11** 
2. **WSL2** (Windows Subsystem for Linux)
3. **Node.js** (v18 or later)
4. **Git** (for repository access)

### Hardware Requirements:
- **RAM**: 8GB+ (16GB recommended)
- **Storage**: Space for your external drive connection
- **CPU**: Any modern processor (2+ cores)

## Step-by-Step Setup

### Phase 1: Install Software
```powershell
# Install WSL2
wsl --install

# Install Node.js (download from nodejs.org)
# Install Git (download from git-scm.com)
```

### Phase 2: Connect External Drive
1. **Connect your external drive** to new PC
2. **Note the drive letter** (e.g., E:\, F:\, etc.)
3. **Verify files exist**: 
   - `lmdb-pages.sqsh` (59GB)
   - `lmdb-images/` folder (697GB)

### Phase 3: Clone Repository
```powershell
# Navigate to your drive
cd E:\  # or whatever your drive letter is

# Clone your GitHub repository
git clone https://github.com/ryaghi23/pistn-ai.git operation-charm

# Navigate to project
cd operation-charm
```

### Phase 4: Install Dependencies in WSL
```bash
# Enter WSL
wsl

# Navigate to project (adjust drive letter as needed)
cd /mnt/e/operation-charm

# Install Node.js in WSL
sudo apt update
sudo apt install -y nodejs npm build-essential python3

# Install project dependencies
npm install
```

### Phase 5: Mount Database & Start
```bash
# Create mount directory
mkdir -p ./lmdb-pages

# Mount squashfs file
sudo mount -o loop -t squashfs ./lmdb-pages.sqsh ./lmdb-pages

# Start server
sudo node server.js / 8080
```

## Quick Setup Script
Save this as `setup-new-pc.bat` on your external drive:
