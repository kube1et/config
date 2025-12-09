#!/bin/bash
# Display the IPs and total number of 404 requests in the last 24h
abort() {
    echo "$@"
    exit 1
}

[ -f "$1" ] || abort "Could not read file: $1"

jq -r 'select(.timestamp > (now - 60*60*24) and .status == "404") | .remote_addr' \
    $1 | sort | uniq -c | sort -nr
