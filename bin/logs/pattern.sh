#!/bin/bash
# Display the IPs and total number of requests in the last 24h for a custom pattern
# Supports a --since argument, for example: --since 12h

abort() {
    echo "$@"
    exit 1
}

seconds() {
    case "$1" in
        *s) echo "${1%s}" ;;
        *m) echo $(( ${1%m} * 60 )) ;;
        *h) echo $(( ${1%h} * 3600 )) ;;
        *d) echo $(( ${1%d} * 86400 )) ;;
        *) echo "$1" ;;
    esac
}

ARGS=()
SINCE=86400

while [ $# -gt 0 ]; do
    case "$1" in
        --since)
            SINCE="$2"
            shift 2
            ;;
        --since=*)
            SINCE="${1#*=}"
            shift
            ;;
        *)
            ARGS+=("$1")
            shift
            ;;
    esac
done

FILENAME="${ARGS[0]}"
PATTERN="${ARGS[1]}"
SINCE=$(seconds "$SINCE")

[ -f "$FILENAME" ] || abort "Could not read file: $FILENAME"
[ ! -z "$PATTERN" ] || abort "Please provide a pattern"

jq -r --arg pattern "$PATTERN" --argjson since "$SINCE" 'select(
        (.timestamp|tonumber) > (now - $since)
        and (.request_uri | contains($pattern))
    ) | .remote_addr' \
    "$FILENAME" | sort | uniq -c | sort -nr
