# Operation CHARM - Vercel + Local API Setup

## Architecture
```
Users → Vercel (Frontend) → Cloudflare Tunnel → Your PC (API + Database)
```

## Benefits
- ✅ **Free hosting** on Vercel's global CDN
- ✅ **Fast worldwide access** 
- ✅ **Database stays local** (no upload needed)
- ✅ **Professional domain** support
- ✅ **Automatic HTTPS**

## Setup Steps

### Step 1: Modify Your Server for API Mode
We'll create a separate API-only version that Vercel can call.

### Step 2: Create Vercel Frontend
Build a lightweight frontend that calls your local API.

### Step 3: Secure Tunnel
Use Cloudflare Tunnel to securely expose your local API.

### Step 4: Deploy to Vercel
Deploy the frontend to Vercel with your custom domain.

## File Structure
```
pistn-ai/
├── api/                 # Local API server (your current setup)
├── frontend/            # Vercel-hosted web interface
├── shared/              # Common components
└── tunnel/              # Tunnel configuration
```

## Advantages over Pure Cloudflare Tunnel
- ✅ Better performance (CDN vs single tunnel)
- ✅ Professional appearance
- ✅ Easy custom domain setup
- ✅ Automatic scaling
- ✅ Built-in analytics
