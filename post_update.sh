#!/bin/sh

. /usr/local/etc/komga-plugin.conf

: "${KOMGA_APP_DIR:=/usr/local/komga}"

# Update komga
# If either backup or update fails, an error message will be printed and you will have to exit, ignore SC2015.
# shellcheck disable=SC2015
komga-backup && komga-clean-backup && komga-update \
|| { echo "❌ Komga update failed." >&2 ; exit 1; }
chown -R komga $KOMGA_APP_DIR

service komga start

{
    echo "✅ komga update is complete!"
    echo "App dir: $KOMGA_APP_DIR"
    echo "Komga version: $(jq -r '.name' release-latest.json)"
} > /root/PLUGIN_INFO
