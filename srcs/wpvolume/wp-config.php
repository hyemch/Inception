<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'hyecheon');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'mariadb');
define('DB_CHARSET', "utf8");
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
$table_prefix = 'wp_';
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
require_once ABSPATH . 'wp-settings.php';
?>
