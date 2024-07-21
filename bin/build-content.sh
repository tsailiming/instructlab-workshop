#!/bin/sh

cp -a showroom/content /tmp
sudo -u showroom -i bash << 'EOF'
cp /opt/showroom/content/www/index.html /opt/showroom/content/www/index.html.bak
cp -a /tmp/content/modules/ROOT/* /opt/showroom/content/content/modules/ROOT/
(cd /opt/showroom/content && podman run -v "./:/antora:Z" antora/antora default-site.yml)
cp /opt/showroom/content/www/index.html.bak /opt/showroom/content/www/index.html
EOF