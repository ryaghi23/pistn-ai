// Script to create Vercel-compatible frontend
const fs = require('fs');
const path = require('path');

console.log('Creating Vercel frontend structure...');

// Create directories
const dirs = ['frontend', 'frontend/public', 'frontend/api', 'frontend/components'];
dirs.forEach(dir => {
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
        console.log(`Created directory: ${dir}`);
    }
});

// Create package.json for frontend
const frontendPackage = {
    "name": "operation-charm-frontend",
    "version": "1.0.0",
    "description": "Operation CHARM Frontend for Vercel",
    "main": "index.js",
    "scripts": {
        "dev": "next dev",
        "build": "next build",
        "start": "next start"
    },
    "dependencies": {
        "next": "^13.0.0",
        "react": "^18.0.0",
        "react-dom": "^18.0.0"
    },
    "devDependencies": {
        "@types/node": "^18.0.0",
        "@types/react": "^18.0.0",
        "typescript": "^4.0.0"
    }
};

fs.writeFileSync('frontend/package.json', JSON.stringify(frontendPackage, null, 2));
console.log('Created frontend/package.json');

// Create vercel.json configuration
const vercelConfig = {
    "name": "operation-charm",
    "version": 2,
    "builds": [
        {
            "src": "frontend/package.json",
            "use": "@vercel/next"
        }
    ],
    "routes": [
        {
            "src": "/api/(.*)",
            "dest": "https://your-tunnel-url.trycloudflare.com/api/$1"
        },
        {
            "src": "/(.*)",
            "dest": "frontend/$1"
        }
    ],
    "env": {
        "API_URL": "https://your-tunnel-url.trycloudflare.com"
    }
};

fs.writeFileSync('vercel.json', JSON.stringify(vercelConfig, null, 2));
console.log('Created vercel.json');

console.log('\n✅ Vercel frontend structure created!');
console.log('\nNext steps:');
console.log('1. cd frontend && npm install');
console.log('2. Create your React components');
console.log('3. Set up Cloudflare Tunnel');
console.log('4. Deploy to Vercel');
