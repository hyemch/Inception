# syntax=docker/dockerfile:1

FROM alpine:3.18

#ARG MYSQL_ROOT_PASSWORD
#ARG MYSQL_USER
#ARG MYSQL_PASSWORD
#ARG MYSQL_DATABASE

# 설치
RUN apk update && apk add --no-cache mysql \
	mysql-client \
	dumb-init

# 설정 적용
RUN mkdir /var/run/mysqld && \
	chmod 755 /var/run/mysqld && \
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf &&\
    sed -i "s|.*skip-networking.*|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

COPY tools/set_db.sh /home/set_db.sh

RUN chmod 755 /home/set_db.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/bin/sh", "/home/set_db.sh"]

