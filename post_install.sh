#!/bin/sh

# Install komga
: "${komga_app_dir='/usr/local/komga'}"
# shellcheck disable=SC2164
cd $komga_app_dir
fetch -qo release-latest.json https://api.github.com/repos/gotson/komga/releases/latest
jq '.assets[] | select(.name | test("komga.*\\.jar")) | .browser_download_url' release-latest.json | xargs fetch -q
jq '.assets[] | select(.name | test("komga.*\\.jar")) | .name' release-latest.json | xargs -I @ ln -s @ komga.jar

pw useradd komga -u 5469 -s /bin/csh -m
chown -R komga $komga_app_dir
sysrc -f /etc/rc.conf komga_enable="YES"

service komga start

{
    echo "✅ komga installation is complete!"
    echo "App dir: $komga_app_dir"
    echo "Komga version: $(jq -r '.name' release-latest.json)"
} > /root/PLUGIN_INFO
