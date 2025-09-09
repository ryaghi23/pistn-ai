# Operation CHARM - Local Hosting Guide

## 💡 Why Local Hosting is Better for You

### ✅ **Advantages:**
- **FREE** - No monthly VPS costs ($0 vs $14-40/month)
- **Fast Access** - 700GB file already on your system
- **No Upload Time** - Skip the 4-8 hour upload process
- **Full Control** - Your hardware, your rules
- **Better Performance** - Direct SSD/HDD access

### ❌ **Considerations:**
- Need to keep your PC running 24/7 for public access
- Uses your internet bandwidth
- Need to configure router/firewall

## 🖥️ Local Setup Options

### Option 1: Internal Network Only (Easiest)
**Perfect for**: Personal use, family access, testing
- Access only from devices on your home network
- No internet configuration needed
- Most secure option

### Option 2: Internet Accessible (Public Website)
**Perfect for**: Sharing with others, public website
- Accessible from anywhere on the internet
- Requires router configuration or tunneling service

## 🚀 Setup Instructions

### Step 1: Choose Your Storage Location

#### **Option A: Keep on I:\ drive (Current Location)**
```bash
# Files are already there - no moving needed!
cd I:\operation-charm
```

#### **Option B: Move to External SSD**
```bash
# Copy everything to external drive (e.g., E:\)
robocopy "I:\operation-charm" "E:\operation-charm" /E /COPYALL

# Then work from external drive
cd E:\operation-charm
```

### Step 2: Run Locally with Docker

```bash
# Make sure Docker is running
docker --version

# Start the application (local network only)
docker-compose up -d

# Check if running
docker-compose ps
```

**Your website will be available at:**
- `http://localhost:8080` (on your PC)
- `http://YOUR_LOCAL_IP:8080` (from other devices on your network)

### Step 3A: Find Your Local IP Address
```bash
# Find your local IP
ipconfig | findstr "IPv4"
```
Example result: `192.168.1.100`

Then access from other devices: `http://192.168.1.100:8080`

## 🌐 Making It Internet Accessible

### Option 1: Router Port Forwarding (Free)

1. **Access your router admin panel**
   - Usually: `http://192.168.1.1` or `http://192.168.0.1`
   - Login with admin credentials

2. **Set up port forwarding**
   - Forward external port `8080` → your PC's IP `:8080`
   - Protocol: TCP
   - Target IP: Your PC's local IP (e.g., 192.168.1.100)

3. **Find your public IP**
   ```bash
   # Check your public IP
   curl ifconfig.me
   ```

4. **Access from internet**
   - `http://YOUR_PUBLIC_IP:8080`

### Option 2: Cloudflare Tunnel (Free & Easier)

```bash
# Install Cloudflare Tunnel
winget install cloudflare.cloudflared

# Authenticate
cloudflared tunnel login

# Create tunnel
cloudflared tunnel create operation-charm

# Configure tunnel
cloudflared tunnel route dns operation-charm yourdomain.com

# Run tunnel
cloudflared tunnel --url http://localhost:8080 run operation-charm
```

### Option 3: ngrok (Free Tier Available)

```bash
# Install ngrok
winget install ngrok

# Authenticate (sign up at ngrok.com for free)
ngrok authtoken YOUR_AUTH_TOKEN

# Create tunnel
ngrok http 8080
```

**Result**: Get a public URL like `https://abc123.ngrok.io`

## 📋 Updated Docker Compose for Local

```yaml
# docker-compose-local.yml
version: '3.8'

services:
  operation-charm:
    build: .
    ports:
      - "8080:8080"
    privileged: true
    volumes:
      # Use your actual path - adjust as needed
      - ./lmdb-pages.sqsh:/app/lmdb-pages.sqsh:ro
    environment:
      - NODE_ENV=production
    restart: unless-stopped
```

## 💰 Cost Comparison

| Option | Monthly Cost | Setup Time | Performance |
|--------|-------------|------------|-------------|
| **Local Only** | $0 | 30 minutes | Excellent |
| **Local + Tunnel** | $0-5 | 1 hour | Excellent |
| **VPS Hosting** | $14-40 | 5-9 hours | Good |

## 🔧 Recommended Setup

### For Personal Use:
```bash
# Just run locally
docker-compose up -d
# Access at http://localhost:8080
```

### For Public Website:
```bash
# Run locally + Cloudflare Tunnel
docker-compose up -d
cloudflared tunnel run operation-charm
# Get public domain access
```

## ⚡ Quick Start Commands

```bash
# 1. Navigate to your project
cd I:\operation-charm

# 2. Start the application
docker-compose up -d

# 3. Check it's working
curl http://localhost:8080

# 4. (Optional) Set up public access with ngrok
ngrok http 8080
```

## 🛠️ Troubleshooting

### If Docker won't start:
```bash
# Restart Docker Desktop
# Or restart the service
net stop com.docker.service
net start com.docker.service
```

### If port 8080 is busy:
```bash
# Check what's using port 8080
netstat -ano | findstr :8080

# Or change port in docker-compose.yml
ports:
  - "8081:8080"  # Use port 8081 instead
```
