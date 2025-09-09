# Operation CHARM - External SSD Setup Guide

## 🚀 Why External SSD is Perfect

### ✅ **Major Advantages:**
- **Faster Performance** - SSD vs HDD = much faster file access
- **Portable** - Move between computers easily
- **Dedicated Storage** - Won't fill up your main drive
- **Cost Effective** - 1TB external SSD ~$80-150 vs $14+/month VPS
- **Better than Internal** - No impact on your main system performance

### 💾 **Recommended External SSDs:**
- **Samsung T7** (1TB ~$100) - Excellent performance, USB 3.2
- **SanDisk Extreme Pro** (1TB ~$120) - Very fast, rugged
- **Crucial X6** (1TB ~$80) - Budget-friendly, good speed
- **WD My Passport SSD** (1TB ~$90) - Reliable, compact

## 🔧 Setup Process

### Step 1: Prepare Your External SSD

1. **Connect your SSD** to your PC via USB 3.0+ port
2. **Format if needed** (NTFS for Windows compatibility)
   ```powershell
   # Check drive letter (e.g., E:, F:, G:)
   Get-Disk
   
   # Format if new drive (replace E: with your drive letter)
   Format-Volume -DriveLetter E -FileSystem NTFS -NewFileSystemLabel "OperationCHARM"
   ```

### Step 2: Move Your Files to SSD

```powershell
# Copy all files from I: drive to external SSD (e.g., E:)
robocopy "I:\operation-charm" "E:\operation-charm" /E /COPYALL /R:3 /W:10

# This will copy:
# - All your project files
# - The 700GB lmdb-pages.sqsh file
# - Preserve all permissions and timestamps
```

**⏱️ Copy Time Estimate:**
- USB 3.0: ~2-3 hours for 700GB
- USB 3.1/3.2: ~1-2 hours for 700GB
- Much faster than internet upload!

### Step 3: Update Docker Configuration

```yaml
# docker-compose-ssd.yml
version: '3.8'

services:
  operation-charm:
    build: .
    ports:
      - "8080:8080"
    privileged: true
    volumes:
      # Update path to your SSD drive letter
      - E:/operation-charm/lmdb-pages.sqsh:/app/lmdb-pages.sqsh:ro
    environment:
      - NODE_ENV=production
    restart: unless-stopped
    working_dir: /app
```

### Step 4: Run from External SSD

```powershell
# Navigate to SSD location
cd E:\operation-charm

# Start the application
docker-compose -f docker-compose-ssd.yml up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

## 🎯 Performance Optimization

### USB Connection Tips:
- **Use USB 3.0+ port** (blue ports are usually USB 3.0)
- **Connect directly to PC** (avoid USB hubs when possible)
- **Use high-quality USB cable** (comes with good SSDs)

### SSD Performance:
```powershell
# Test SSD speed (optional)
winsat disk -drive E:
```

Expected speeds:
- **Good External SSD**: 400-500 MB/s read
- **Internal SATA SSD**: 500-550 MB/s read
- **Regular HDD**: 100-150 MB/s read

## 📁 Recommended Folder Structure on SSD

```
E:\operation-charm\
├── lmdb-pages.sqsh          (700GB - your main data)
├── lmdb-images\
│   └── data.mdb
├── server.js
├── package.json
├── Dockerfile
├── docker-compose-ssd.yml
├── html\
└── ... (all other files)
```

## 🔄 Easy Switching Between Drives

Create batch files for easy switching:

### `start-from-ssd.bat`
```batch
@echo off
cd /d E:\operation-charm
docker-compose -f docker-compose-ssd.yml up -d
echo Operation CHARM started from SSD
echo Access at: http://localhost:8080
pause
```

### `start-from-internal.bat`
```batch
@echo off
cd /d I:\operation-charm
docker-compose up -d
echo Operation CHARM started from internal drive
echo Access at: http://localhost:8080
pause
```

## 💡 Pro Tips

### Power Management:
- **Disable USB selective suspend** to prevent SSD from sleeping:
  ```
  Control Panel → Power Options → Change plan settings 
  → Change advanced power settings → USB settings 
  → USB selective suspend setting → Disabled
  ```

### Backup Strategy:
- Keep original files on I: drive as backup
- External SSD becomes your "production" copy
- Easy to backup: just copy the SSD contents

### Multiple SSDs:
- Use one SSD for development/testing
- Use another for production
- Easy to swap between versions

## 🌐 Internet Access Options

Your external SSD setup works with all internet access methods:

1. **Local Network Only**: `http://192.168.x.x:8080`
2. **Router Port Forwarding**: `http://your-public-ip:8080`
3. **Cloudflare Tunnel**: `https://yourdomain.com`
4. **ngrok**: `https://abc123.ngrok.io`

## 📊 Cost Comparison

| Option | Initial Cost | Monthly Cost | Performance | Portability |
|--------|-------------|-------------|-------------|-------------|
| **External SSD** | $80-150 | $0 | Excellent | ✅ High |
| **Internal Storage** | $0 | $0 | Good | ❌ None |
| **VPS Hosting** | $0 | $14-40 | Good | ✅ High |

## 🚀 Quick Start Commands

```powershell
# 1. Connect and format SSD (if new)
Format-Volume -DriveLetter E -FileSystem NTFS -NewFileSystemLabel "OperationCHARM"

# 2. Copy files to SSD
robocopy "I:\operation-charm" "E:\operation-charm" /E /COPYALL

# 3. Navigate to SSD
cd E:\operation-charm

# 4. Start application
docker-compose -f docker-compose-ssd.yml up -d

# 5. Access website
start http://localhost:8080
```

## 🛠️ Troubleshooting

### If SSD not recognized:
- Try different USB port
- Check Device Manager for driver issues
- Ensure SSD has power (some need Y-cables)

### If Docker can't access SSD files:
- Check drive letter in docker-compose-ssd.yml
- Ensure Docker Desktop has access to the drive
- Try running Docker as administrator

### Performance issues:
- Check USB port type (use USB 3.0+)
- Defragment SSD (rare but sometimes helps)
- Check for background processes using the drive
