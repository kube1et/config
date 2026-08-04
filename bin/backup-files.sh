#!/bin/bash
set -euo pipefail

TIMESTAMP=$(date +%Y%m%d-%H%M%S)

for docroot in /sites/*/public_html; do
	[ -d "$docroot" ] || continue
	[ -f "$docroot/wp-config.php" ] || continue

	site=$(basename "$(dirname "$docroot")")

	dest_dir="/backups/$site"
	mkdir -p "$dest_dir"
	dest_file="$dest_dir/${TIMESTAMP}.tar.gz"
	echo "[$site] archiving files to $dest_file"

	status=0
	tar -czf "$dest_file" --exclude='wp-content/cache' -C "$docroot" . || status=$?

	if [ "$status" -eq 0 ]; then
		echo "[$site] done"
	elif [ "$status" -eq 1 ]; then
		echo "[$site] some files changed while archiving, keeping backup" >&2
	else
		echo "[$site] tar failed" >&2
		rm -f "$dest_file"
	fi
done
