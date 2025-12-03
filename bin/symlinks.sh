#!/bin/bash
set -ex

# SSH, keys, sudoers
mkdir -p /home/karl/.ssh
chown karl:karl /home/karl/.ssh
ln -sfn /config/misc/authorized_keys /home/karl/.ssh/authorized_keys
ln -sfn /config/misc/sshd.conf /etc/ssh/sshd_config.d/sshd.conf
ln -sfn /config/misc/sudoers /etc/sudoers.d/sudoers
ln -sfn /config/misc/sshd.pam.conf /etc/pam.d/sshd
ln -sfn /config/misc/bash_aliases /home/karl/.bash_aliases

# WP-CLI
mkdir -p /var/www/.wp-cli/cache
chown -R www-data:www-data /var/www/.wp-cli
ln -sfn /config/misc/wp-cli.yml /var/www/.wp-cli/config.yml

# Global fail2ban
ln -sfn /config/misc/fail2ban/jail.conf /etc/fail2ban/jail.d/jail.conf

# Logrotate
ln -sfn /config/misc/logrotate.rsyslog /etc/logrotate.d/rsyslog
ln -sfn /config/misc/logrotate.sites /etc/logrotate.d/sites
ln -sfn /config/misc/logrotate.mariadb /etc/logrotate.d/mariadb-custom

# Sysctl
ln -sfn /config/misc/sysctl.conf /etc/sysctl.d/wpshell.conf

# Crontab
ln -sfn /config/misc/crontab /etc/cron.d/crontab

# Global PHP configs
ln -sfn /config/php/php.ini /etc/php/8.3/fpm/php.ini
ln -sfn /config/php/php.ini /etc/php/8.3/cli/php.ini
ln -sfn /config/php/php-fpm.conf /etc/php/8.3/fpm/php-fpm.conf
ln -sfn /config/php/cli.ini /etc/php/8.3/cli/conf.d/cli.ini

# Global Nginx configs
ln -sfn /config/nginx/nginx.conf /etc/nginx/nginx.conf

# Per-site PHP pool configs
ln -sfn /config/php/uncached.org.conf /etc/php/8.3/fpm/pool.d/uncached.org.conf

# Per-site Nginx configs
ln -sfn /config/nginx/uncached.org.conf /etc/nginx/sites-enabled/uncached.org.conf

# Global MariaDB config
ln -sfn /config/mysql/global.cnf /etc/mysql/mariadb.conf.d/99-global.cnf

# phpMyAdmin
ln -sfn /config/php/phpmyadmin.conf /etc/php/8.3/fpm/pool.d/phpmyadmin.conf
ln -sfn /config/nginx/phpmyadmin.conf /etc/nginx/sites-enabled/phpmyadmin.conf

# Postfix
ln -sfn /config/postfix/main.cf /etc/postfix/main.cf
ln -sfn /config/postfix/master.cf /etc/postfix/master.cf

# Redis
ln -sfn /config/misc/redis.conf /etc/redis/redis.conf

# Memcached
ln -sfn /config/misc/memcached.conf /etc/memcached.conf

# Per-site mu-plugins
mkdir -p /sites/uncached.org/public_html/wp-content/mu-plugins
chown www-data:www-data /sites/uncached.org/public_html/wp-content/mu-plugins
ln -sfn /config/misc/fail2ban/fail2ban.php /sites/uncached.org/public_html/wp-content/mu-plugins/fail2ban.php
