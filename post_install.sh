#!/bin/sh

. /usr/local/etc/komga-plugin.conf
: "${KOMGA_APP_DIR:=/usr/local/komga}"

# Install komga
pw useradd komga -u 5469 -s /bin/csh -m
komga-update || { echo "❌ Komga install failed." >&2 ; exit 1; }
chown -R komga $KOMGA_APP_DIR
sysrc -f /etc/rc.conf komga_enable="YES"

service komga start

{
    echo "✅ komga installation is complete!"
    echo "App dir: $KOMGA_APP_DIR"
    echo "Komga version: $(jq -r '.name' release-latest.json)"
} > /root/PLUGIN_INFO
