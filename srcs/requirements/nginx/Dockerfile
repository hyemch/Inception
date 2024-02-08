# syntax=docker/dockerfile:1

FROM alpine:3.18

ARG SSL_PATH=/etc/ssl/private

RUN apk update && \
    apk --no-cache add nginx \
    openssl \
    dumb-init && \
    adduser -D hyecheon

RUN openssl genrsa -out ${SSL_PATH}/hyecheon.42.fr.key 2048 && \
    openssl req -new -key ${SSL_PATH}/hyecheon.42.fr.key -out ${SSL_PATH}/hyecheon.42.fr.crt \
    -subj "/C=KR/ST=Seoul/L=Gaepodong/O=42seoul/OU=Cadet/CN=hyecheon.42.kr" && \
    openssl x509 -req -days 1000 -in ${SSL_PATH}/hyecheon.42.fr.crt -signkey ${SSL_PATH}/hyecheon.42.fr.key -out ${SSL_PATH}/hyecheon.42.fr.crt && \
    chown -R nginx ${SSL_PATH} &&\
    mkdir /etc/nginx/conf.d &&\
    chmod 755 /etc/nginx/conf.d

WORKDIR /var/www/html

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443
ENTRYPOINT ["/usr/bin/dumb-init", "--", "nginx", "-g", "daemon off;"]