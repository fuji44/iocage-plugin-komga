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
