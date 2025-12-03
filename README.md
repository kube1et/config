# WP Shell Configuration Repo

This is the sample repository used for WP Shell, the [self-hosting WordPress
course](https://wpshell.com). It contains configuration for Nginx, PHP, MariaDB,
Fail2ban and other software, typically used for running WordPress applications.

Do not fork this repository. Instead, clone it and customize it to your needs.
If you are going to publish it, make sure **it is private** as it will contain
sensitive information in configuration files.

I typically keep it in a `/config` directory on the destination server, but you
can use `/srv/config`, `/opt/config` or another directory. It has to mostly be
public, accessible by various software, which doesn't always run as `root`.
However, some files (SSH keys, etc.) must remain private to the owner, and there
is a helper script for that.

Here's a brief outline of the top-level items:

* `bin` - helper scripts to install/update software, fix permissions and other things
* `nginx` - global and per-site Nginx configuration
* `php` - PHP-CLI, PHP-FPM and pool configuration
* `mysql` - MariaDB global configuration
* `postfix` - Email relay configuration
* `ssl` - SSL keys and certificates
* `misc` - everything else

If you're interested in a step-by-step tutorial on using this for your WordPress
projects, check out [wpshell.com](https://wpshell.com). If you have any
questions, don't hesitate to pop into our Discord community, or email me:
hi@wpshell.com.
