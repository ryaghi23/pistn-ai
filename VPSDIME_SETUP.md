# Operation CHARM - VPSDime VPS Setup Guide

## Step 1: Sign Up for VPSDime

1. Go to [VPSDime.com](https://vpsdime.com/storage-vps)
2. Choose the **Storage VPS** plan:
   - **1TB Storage VPS**: $14/month
   - 4 CPU cores, 2GB RAM, 1TB HDD
   - RAID10 protection
3. Select:
   - **OS**: Ubuntu 22.04 LTS
   - **Location**: Choose closest to your target audience
   - **Billing**: Monthly
4. Complete signup and payment

## Step 2: Initial VPS Setup

Once your VPS is ready, you'll receive:
- IP address
- Root password
- SSH access details

### Connect to your VPS:
```bash
ssh root@YOUR_VPS_IP
```

### Update the system:
```bash
apt update && apt upgrade -y
```

### Install Docker:
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
apt install docker-compose -y

# Verify installation
docker --version
docker-compose --version
```

## Step 3: Upload Your Files

### Option A: Direct Upload (Recommended for large files)
```bash
# Create project directory
mkdir /opt/operation-charm
cd /opt/operation-charm

# Upload files using rsync (from your Windows machine)
# Install rsync on Windows first: winget install rsync
rsync -avz --progress /cygdrive/i/operation-charm/ root@YOUR_VPS_IP:/opt/operation-charm/
```

### Option B: SCP Upload
```bash
# From your Windows machine (use PowerShell or Git Bash)
scp -r "I:\operation-charm\*" root@YOUR_VPS_IP:/opt/operation-charm/
```

**Note**: The 700GB upload will take several hours depending on your internet speed.

## Step 4: Deploy the Application

```bash
# On the VPS, navigate to project directory
cd /opt/operation-charm

# Start the application
docker-compose up -d

# Check if it's running
docker-compose ps
docker-compose logs -f operation-charm
```

## Step 5: Configure Firewall

```bash
# Allow necessary ports
ufw allow 22    # SSH
ufw allow 8080  # Application port
ufw enable

# Check status
ufw status
```

## Step 6: Access Your Website

Your Operation CHARM website will be available at:
```
http://YOUR_VPS_IP:8080
```

## Step 7: Optional - Set up Domain Name

1. **Buy a domain** (e.g., from Namecheap, GoDaddy)
2. **Point A record** to your VPS IP
3. **Set up Nginx reverse proxy** (optional):

```bash
apt install nginx -y

# Create Nginx config
cat > /etc/nginx/sites-available/operation-charm << 'EOF'
server {
    listen 80;
    server_name yourdomain.com;
    
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF

# Enable site
ln -s /etc/nginx/sites-available/operation-charm /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx
```

## Troubleshooting

### If upload is too slow:
- Use `screen` to run upload in background: `screen rsync ...`
- Consider uploading overnight
- Use `--partial --progress` flags with rsync

### If Docker fails:
```bash
# Check Docker status
systemctl status docker

# Restart Docker
systemctl restart docker

# Check logs
docker-compose logs
```

### If out of memory:
- The 2GB RAM might be tight. Monitor with `htop`
- Consider upgrading to higher RAM plan if needed

## Monitoring

```bash
# Check disk usage
df -h

# Check memory usage
free -h

# Monitor Docker containers
docker stats

# Check application logs
docker-compose logs -f --tail=100
```

## Estimated Timeline

- VPS setup: 30 minutes
- File upload: 4-8 hours (for 700GB)
- Application deployment: 15 minutes
- **Total**: 5-9 hours (mostly waiting for upload)
