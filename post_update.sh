#!/bin/sh

# Install komga
: "${komga_app_dir='/usr/local/komga'}"
cd $komga_app_dir || { echo "Komga app dir not found."; exit 1; }
mv -f release-latest.json release-previous.json
fetch -qo release-latest.json https://api.github.com/repos/gotson/komga/releases/latest
jq '.assets[] | select(.name | test("komga.*\\.jar")) | .browser_download_url' release-latest.json | xargs fetch -q
jq '.assets[] | select(.name | test("komga.*\\.jar")) | .name' release-latest.json | xargs -I @ ln -sf @ komga.jar

chown -R komga $komga_app_dir

service komga start

{
    echo "✅ komga update is complete!"
    echo "App dir: $komga_app_dir"
    echo "Komga version: $(jq -r '.name' release-latest.json)"
} > /root/PLUGIN_INFO
