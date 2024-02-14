#!/bin/sh

if [ ! -f "/var/www/html/wp-config.php" ]; then

mv /home/wp-config.php /var/www/html/wp-config.php

wp core download --locale=ko_KR --allow-root --path=${WORDPRESS_PATH}

wp core install --allow-root --path=${WORDPRESS_PATH} \
--url=${WORDPRESS_URL} --title=${WORDPRESS_TITLE} \
--admin_user=${WORDPRESS_ADMIN_USER} \
--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
--admin_email=${WORDPRESS_ADMIN_EMAIL} --skip-email

wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} \
--user_pass=${WORDPRESS_USER_PASSWORD} --role=author --allow-root

chmod -R 777 /var/www/html/wp-content
fi

/usr/sbin/php-fpm81 -F