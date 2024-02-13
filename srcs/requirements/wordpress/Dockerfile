# syntax=docker/dockerfile:1

FROM alpine:3.18

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DATABASE

ARG MYSQL_USER=$MYSQL_USER
ARG MYSQL_PASSWORD=$MYSQL_PASSWORD
ARG MYSQL_DATABASE=$MYSQL_DATABASE


RUN apk update && \
    apk --no-cache add php \
    php-fpm \
    php-phar \
    php-curl \
    php-mysqli \
    php-mbstring \
    dumb-init

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/php81/php-fpm.d/www.conf && \
    mkdir -p /var/www/html &&\
    chmod 777 /var/www/html

WORKDIR /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    php wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/set-wp-config.sh /home/set-wp-config.sh
COPY ./tools/wp-script.sh /home/wp-script.sh

EXPOSE 9000

RUN chmod 777 /home/set-wp-config.sh && \
    chmod 777 /home/wp-script.sh

RUN /bin/sh /home/set-wp-config.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/bin/sh", "/home/wp-script.sh"]