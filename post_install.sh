#!/bin/sh

# Install komga
: ${komga_app_dir="/usr/local/komga"}
mkdir $komga_app_dir
cd $komga_app_dir
fetch -o release-latest.json https://api.github.com/repos/gotson/komga/releases/latest
jq '.assets[] | select(.name | test("komga.*\\.jar")) | .browser_download_url' release-latest.json | xargs curl -sLJO
jq '.assets[] | select(.name | test("komga.*\\.jar")) | .name' release-latest.json | xargs -I @ ln -s @ komga.jar

pw useradd komga -s /bin/csh -m
chown -R komga $komga_app_dir
sysrc -f /etc/rc.conf komga_enable="YES"

service komga start

echo "✅ komga installation is complete!" > /root/PLUGIN_INFO
echo "App dir: $komga_app_dir" >> /root/PLUGIN_INFO
