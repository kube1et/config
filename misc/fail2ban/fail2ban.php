<?php
function wpshell_failed_login() {
	$ip = $_SERVER['REMOTE_ADDR'];
	$host = strtolower( $_SERVER['HTTP_HOST'] );

	openlog( 'wordpress', 0, LOG_AUTH );
	syslog( LOG_WARNING, "login-failed ip:{$ip} host:{$host}" );
	closelog();
}

add_action( 'wp_login_failed', 'wpshell_failed_login' );
add_action( 'application_password_failed_authentication', 'wpshell_failed_login' );
