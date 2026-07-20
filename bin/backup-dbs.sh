#!/bin/bash
set -euo pipefail

TIMESTAMP=$(date +%Y%m%d-%H%M%S)

for docroot in /sites/*/public_html; do
	[ -d "$docroot" ] || continue
	[ -f "$docroot/wp-config.php" ] || continue 

	site=$(basename "$(dirname "$docroot")")
	user=$(stat -c '%U' "$docroot/wp-config.php")

	db_name=$(sudo -u "$user" -H -- wp config get DB_NAME --path="$docroot" --skip-plugins --skip-themes 2>/dev/null) || {
		echo "[$site] could not read DB_NAME, skipping" >&2
		continue
	}

	dest_dir="/backups/$site"
	mkdir -p "$dest_dir"
	dest_file="$dest_dir/${TIMESTAMP}.sql.gz"
	echo "[$site] dumping $db_name to $dest_file"
	if mysqldump --single-transaction --quick "$db_name" | gzip > "$dest_file"; then
		echo "[$site] done"
	else
		echo "[$site] mysqldump failed" >&2
		rm -f "$dest_file"
	fi
done
