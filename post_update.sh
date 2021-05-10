#!/bin/sh

# Install komga
: ${komga_app_dir="/usr/local/komga"}
cd $komga_app_dir
mv -f release-latest.json release-old.json
fetch -qo release-latest.json https://api.github.com/repos/gotson/komga/releases/latest
jq '.assets[] | select(.name | test("komga.*\\.jar")) | .browser_download_url' release-latest.json | xargs fetch -q
jq '.assets[] | select(.name | test("komga.*\\.jar")) | .name' release-latest.json | xargs -I @ ln -sf @ komga.jar

chown -R komga $komga_app_dir

service komga restart

echo "✅ komga update is complete!" > /root/PLUGIN_INFO
echo "App dir: $komga_app_dir" >> /root/PLUGIN_INFO
echo "Komga version: `jq '.name' release-latest.json`" >> /root/PLUGIN_INFO
