#!/bin/bash
set -e

IP="$1"
TARGET="/etc/nginx/blacklisted-manual.geo"

if [ -z "$IP" ]; then
    echo "Usage: $0 IP_ADDRESS"
    exit 1
fi

if ! grep -q "^$IP " "$TARGET"; then
    echo "$IP is not banned"
    exit 0
fi

sed -i "/^$IP /d" "$TARGET"

if ! nginx -t >/dev/null 2>&1; then
    echo "Nginx config test error"
    exit 1
fi

systemctl reload nginx.service
echo "Unbanned: $IP"
