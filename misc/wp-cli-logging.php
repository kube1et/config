<?php
if ( ! defined( 'WP_CLI' ) || ! WP_CLI ) {
	return;
}

\WP_CLI::add_hook( 'before_wp_load', function() {
	ini_set( 'log_errors', '1' );
	ini_set( 'error_log', dirname( ABSPATH ) . '/logs/php-errors.log' );

	$command = implode( ' ', $_SERVER['argv'] );
	$user = getenv( 'SUDO_USER' )
		?: getenv( 'USER' )
		?: getenv( 'LOGNAME' )
		?: 'unknown';

	$line = sprintf(
		"[%s] user=%s cmd=%s\n",
		date( 'Y-m-d H:i:s' ),
		$user,
		$command
	);

	file_put_contents(
		dirname( ABSPATH ) . '/logs/cli.log',
		$line,
		FILE_APPEND | LOCK_EX
	);
} );
