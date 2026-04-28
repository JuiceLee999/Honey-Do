#!/bin/bash
# Server-side deploy script for Honey Do — runs on 159.203.111.124
set -e

DEPLOY_DIR="/var/www/HoneyDo"

echo "==> Deploying Honey Do..."
cd "$DEPLOY_DIR"

echo "==> Pulling latest from main..."
git pull origin main

echo "==> Installing dependencies..."
npm install --omit=dev

echo "==> Clearing stale DB lock (if any)..."
rm -rf "$DEPLOY_DIR/db/homeworks.db.lock"

echo "==> Restarting app..."
if command -v pm2 &> /dev/null; then
  BASE_PATH=/hp pm2 restart honey-do 2>/dev/null || BASE_PATH=/hp pm2 start server.js --name honey-do --cwd "$DEPLOY_DIR"
  pm2 save
else
  echo "WARNING: pm2 not found. Install it: npm install -g pm2"
fi

echo "==> Done. Honey Do is live on port 3000 at /hp"
