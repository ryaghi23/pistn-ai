# Operation CHARM - Deployment Guide

## Prerequisites
- VPS with at least 1TB storage and 8GB RAM
- Docker and Docker Compose installed
- SSH access to the server

## Step 1: Set up VPS (DigitalOcean Example)

1. Create a DigitalOcean account
2. Create a new Droplet:
   - **Image**: Ubuntu 22.04 LTS
   - **Size**: Basic plan, 8GB RAM, 4 vCPUs, 160GB SSD
   - **Add Block Storage**: 1TB volume for the squashfs file
3. Add your SSH key for secure access

## Step 2: Server Setup

```bash
# Connect to your server
ssh root@your-server-ip

# Update system
apt update && apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
apt install docker-compose -y

# Create project directory
mkdir /opt/operation-charm
cd /opt/operation-charm
```

## Step 3: Upload Files

```bash
# Upload your project files (use scp or rsync)
# From your local machine:
scp -r I:/operation-charm/* root@your-server-ip:/opt/operation-charm/

# Or use rsync for better performance with large files:
rsync -avz --progress I:/operation-charm/ root@your-server-ip:/opt/operation-charm/
```

## Step 4: Deploy Application

```bash
# On the server, in /opt/operation-charm
docker-compose up -d

# Check if it's running
docker-compose ps
docker-compose logs -f
```

## Step 5: Configure Firewall & Domain

```bash
# Allow HTTP and HTTPS traffic
ufw allow 80
ufw allow 443
ufw allow 8080
ufw enable

# Set up reverse proxy with Nginx (optional)
apt install nginx -y
```

## Step 6: Access Your Website

Your Operation CHARM website will be available at:
- `http://your-server-ip:8080`
- Or with a domain: `http://yourdomain.com:8080`

## Estimated Costs

- **DigitalOcean**: $40-80/month (droplet + block storage)
- **Domain**: $10-15/year
- **Total**: ~$500-1000/year

## Performance Optimization

- Use SSD storage for better performance
- Enable gzip compression
- Set up CDN for static assets
- Monitor resource usage with `htop` and `docker stats`
