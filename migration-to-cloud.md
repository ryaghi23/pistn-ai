# Migration to Cloud Hosting

## Step-by-Step Cloud Migration

### Phase 1: Prepare VPS
1. **Sign up** for Hetzner Cloud
2. **Create VPS**: CX31 (4GB RAM, 80GB SSD) + 1TB Volume
3. **Install**: Ubuntu 22.04 LTS
4. **Set up**: Node.js, npm, required packages

### Phase 2: Upload Database Files
```bash
# Option A: Direct upload (slow but simple)
scp -r lmdb-pages.sqsh lmdb-images/ user@your-vps:/app/

# Option B: Cloud storage transfer (faster)
# Upload to cloud storage first, then download to VPS
```

### Phase 3: Deploy Application
```bash
# On VPS:
git clone https://github.com/ryaghi23/pistn-ai.git
cd pistn-ai
npm install
# Mount squashfs file
sudo mount -o loop -t squashfs lmdb-pages.sqsh lmdb-pages/
# Start server
node server.js / 8080
```

### Phase 4: Configure Domain
1. **Update DNS**: Point pistn.ai to VPS IP
2. **Install SSL**: Use Let's Encrypt/Certbot
3. **Configure nginx**: Reverse proxy for better performance

### Phase 5: Monitoring & Maintenance
- **Process manager**: PM2 for auto-restart
- **Backups**: Automated database backups
- **Updates**: Auto-update system packages
- **Monitoring**: Uptime monitoring service

## Estimated Migration Time:
- **VPS Setup**: 1 hour
- **File Upload**: 4-12 hours (depending on connection)
- **Configuration**: 2 hours
- **Testing**: 1 hour
- **Total**: 8-16 hours
