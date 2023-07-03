#!/bin/bash

# Enter in folder
cd /opt/uptime-kuma/

# tag latest releases
tag=$(curl --silent "https://api.github.com/repos/louislam/uptime-kuma/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Update from git
git fetch --all
git checkout $tag --force

# Install dependencies and prebuilt
npm install --production
npm run download-dist

# Enable iframe
sed -i 's/\(.*disableFrameSameOrigin.*=.*\)false;/\1true;/' server/server.js

# Restart
service uptimeKuma restart
