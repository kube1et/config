#!/bin/bash
# Display the IPs and total number of search requests in the last 24h
abort() {
    echo "$@"
    exit 1
}

[ -f "$1" ] || abort "Could not read file: $1"

jq -r 'select(
    .timestamp > (now - 60*60*24)
    and (.request_uri | contains("?s="))
  ) | .remote_addr
' "$1" | sort | uniq -c | sort -nr

