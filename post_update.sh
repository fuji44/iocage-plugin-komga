#!/bin/sh

. /usr/local/komga/.env

: "${KOMGA_APP_DIR:=/usr/local/komga}"

# Update komga
. /usr/local/komga/bin/komga-update || { echo "❌ Komga update failed." >&2 ; exit 1; }

service komga start

{
    echo "✅ komga update is complete!"
    echo "App dir: $KOMGA_APP_DIR"
    echo "Komga version: $(jq -r '.name' release-latest.json)"
} > /root/PLUGIN_INFO
