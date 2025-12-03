#!/bin/bash
set -ex

apt install \
	php8.3-fpm \
	mariadb-server \
	redis-server \
  memcached \
	nginx \
	jq \
	postfix \
	phpmyadmin \
	datamash \
	acl \
	libpam-google-authenticator \
	moreutils \
  curl \
  wget \
  fail2ban

# WP-CLI with completion
curl -o wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
chown root:root /usr/local/bin/wp

curl -o wp-completion.bash https://raw.githubusercontent.com/wp-cli/wp-cli/main/utils/wp-completion.bash
mv wp-completion.bash /etc/bash_completion.d/wp-completion.bash
