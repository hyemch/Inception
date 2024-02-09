#!/bin/sh

wp core download --locale=ko_KR --allow-root --path=/var/www/html

wp core install --allow-root \
--path=${WORDPRESS_PATH} \
--url=${WORDPRESS_URL} \
--title=${WORDPRESS_TITLE} \
--admin_user=${WORDPRESS_ADMIN} \
--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
--admin_email=${WORDPRESS_ADMIN_EMAIL} \
--skip-email

wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} \
--user_pass=${WORDPRESS_USER_PASSWORD} \
--role=author \
--allow-root && \

chmod -R 777 /var/www/html/wp-content

