#!/bin/bash
set -e

IP="$1"
shift
COMMENT="$*"
TARGET="/etc/nginx/blacklisted-manual.geo"
TIMESTAMP="$(date -u +"%Y-%m-%d")"

if [ -z "$IP" ]; then
    echo "Usage: $0 IP_ADDRESS [COMMENT]"
    exit 1
fi

if grep -q "^$IP " "$TARGET"; then
    echo "$IP is already banned"
    exit 0
fi

LINE="$IP 1; # $TIMESTAMP"
if [ ! -z "$COMMENT" ]; then
    LINE="$LINE $COMMENT"
fi

echo "$LINE" >> "$TARGET"

if ! nginx -t >/dev/null 2>&1; then
    echo "Nginx config test error"
    exit 1
fi

systemctl reload nginx.service
echo "Banned: $IP"
