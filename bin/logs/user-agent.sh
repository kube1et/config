#!/bin/bash
# Display the top user agents in the last 24 hours
abort() {
    echo "$@"
    exit 1
}

[ -f "$1" ] || abort "Could not read file: $1"

jq -r 'select(.timestamp > (now - 60*60*24)) | .user_agent' \
  $1 | sort | uniq -c | sort -nr

