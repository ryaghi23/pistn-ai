FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    squashfs-tools \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy only necessary files (not the large squashfs file)
COPY package.json ./
COPY node-lmdb-patched.tar.gz ./
RUN npm install

# Copy application files (excluding large data files via .dockerignore)
COPY server.js ./
COPY *.html ./
COPY html/ ./html/

# Create mount point for squashfs
RUN mkdir -p /app/lmdb-pages

# Expose port
EXPOSE 8080

# Mount squashfs and start the application
CMD ["sh", "-c", "mount -o loop -t squashfs /data/lmdb-pages.sqsh /app/lmdb-pages && npm start / 8080"]
