#!/bin/bash
set -euo pipefail

KEEP=14

echo "Removing backups older than $KEEP days"
find /backups -type f -name '*.gz' -mtime +$KEEP -print -delete
