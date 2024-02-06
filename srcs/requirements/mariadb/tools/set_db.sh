#!/bin/sh

if [ -d "/run/mysqld" ]; then
    chown -R mysql:mysql /run/mysqld
else
    mkdir -p /run/mysqld
    chown -R mysql:mysqld /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --datadir=/var/lib/mysql --user=mysql
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then
  cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FORM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

  /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
          rm -f /tmp/create_db.sql
fi

exec /usr/bin/mysqld --user=mysql --skip-log-error

#mysql -u mysql