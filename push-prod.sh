#!/bin/bash
# Local script — merges dev into main, pushes to Honey-Do repo, deploys to prod
# Usage: bash push-prod.sh

set -e

PROD_HOST="159.203.111.124"
PROD_USER="root"
PROD_DIR="/var/www/HoneyDo"

echo "==> Switching to main..."
git checkout main

echo "==> Merging dev into main..."
git merge dev --no-edit

echo "==> Pushing main to GitHub (Honey-Do)..."
git push origin main

echo "==> Deploying to production ($PROD_HOST)..."
ssh "$PROD_USER@$PROD_HOST" "bash $PROD_DIR/scripts/deploy.sh"

echo "==> Switching back to dev..."
git checkout dev

echo ""
echo "✓ Production deploy complete — https://honey-do.hopto.org/hp"
