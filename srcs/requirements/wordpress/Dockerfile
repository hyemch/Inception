# syntax=docker/dockerfile:1

FROM alpine:3.18

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DATABASE
ARG WORDPRESS_PATH
ARG WORDPRESS_TITLE
ARG WORDPRESS_URL
ARG WORDPRESS_WWW
ARG WORDPRESS_ADMIN_USER
ARG WORDPRESS_ADMIN_PASSWORD
ARG WORDPRESS_ADMIN_EMAIL
ARG WORDPRESS_USER
ARG WORDPRESS_USER_PASSWORD
ARG WORDPRESS_USER_EMAIL

ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV WORDPRESS_PATH=${WORDPRESS_PATH}
ENV WORDPRESS_TITLE=${WORDPRESS_TITLE}
ENV WORDPRESS_URL=${WORDPRESS_URL}
ENV WORDPRESS_WWW=${WORDPRESS_WWW}
ENV WORDPRESS_ADMIN_USER=${WORDPRESS_ADMIN_USER}
ENV WORDPRESS_ADMIN_PASSWORD=${WORDPRESS_ADMIN_PASSWORD}
ENV WORDPRESS_ADMIN_EMAIL=${WORDPRESS_ADMIN_EMAIL}
ENV WORDPRESS_USER=${WORDPRESS_USER}
ENV WORDPRESS_USER_PASSWORD=${WORDPRESS_USER_PASSWORD}
ENV WORDPRESS_USER_EMAIL=${WORDPRESS_USER_EMAIL}

RUN apk update &&\
    apk --no-cache add php \
    php-fpm \
    php-phar \
    php-curl \
    php-mysqli \
    php-mbstring \
    dumb-init

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/php81/php-fpm.d/www.conf

WORKDIR /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    php wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/set-wp-config.sh /home/set-wp-config.sh
COPY ./tools/install-wp.sh /home/install-wp.sh

EXPOSE 9000

RUN chmod 777 /home/set-wp-config.sh && \
    chmod 777 /home/install-wp.sh

RUN /home/set-wp-config.sh && \
    /home/install-wp.sh



ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/sbin/php-fpm81", "-F"]