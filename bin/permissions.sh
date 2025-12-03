#!/bin/bash
set -ex

chmod 0600 /config/postfix/sasl_passwd
chmod 0600 /config/postfix/sasl_passwd.db
chmod 0600 /config/ssl/*.key.pem

# Strict permissions for SSH auth keys
chown karl:karl /config/misc/authorized_keys
chmod 0600 /config/misc/authorized_keys

# Strict perms for fail2ban jail (can have Cloudflare API keys)
chmod 0600 /config/misc/fail2ban/jail.conf

# Let karl edit some www-data files
setfacl -Rm u:karl:rwX /sites
setfacl -Rdm u:karl:rwX /sites
chown -R www-data:www-data /sites
