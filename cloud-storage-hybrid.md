# Hybrid Cloud Storage Solution

## Architecture: Separate Compute and Storage

### Storage Options for Large Files:
1. **AWS S3** - $18/month for 800GB
2. **Google Cloud Storage** - $16/month for 800GB  
3. **Backblaze B2** - $4/month for 800GB (CHEAPEST)
4. **Wasabi** - $6/month for 800GB

### Compute Options (Small VPS):
1. **Railway** - $5/month
2. **DigitalOcean Basic** - $4/month
3. **Linode Nanode** - $5/month

## Total Costs:
- **Cheapest**: Backblaze B2 + Railway = $9/month
- **Best Performance**: AWS S3 + DigitalOcean = $22/month
- **Balanced**: Wasabi + Railway = $11/month

## Pros:
- ✅ Lower monthly costs
- ✅ Separate scaling of storage/compute
- ✅ Better backup/redundancy

## Cons:
- ❌ More complex setup
- ❌ Potential latency for database queries
- ❌ Data transfer costs
- ❌ Need to modify LMDB to work with cloud storage
