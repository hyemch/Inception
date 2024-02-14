# syntax=docker/dockerfile:1

FROM alpine:3.18

RUN apk update && \
    apk --no-cache add nginx openssl dumb-init && \
    adduser -D hyecheon

RUN mkdir -p /etc/ssl/private &&\
    openssl genrsa -out /etc/ssl/private/hyecheon.42.fr.key 2048 && \
    openssl req -new -key /etc/ssl/private/hyecheon.42.fr.key -out /etc/ssl/private/hyecheon.42.fr.crt \
    -subj "/C=KR/ST=Seoul/L=Gaepodong/O=42seoul/OU=Cadet/CN=hyecheon.42.kr" && \
    openssl x509 -req -days 1000 -in /etc/ssl/private/hyecheon.42.fr.crt -signkey /etc/ssl/private/hyecheon.42.fr.key -out /etc/ssl/private/hyecheon.42.fr.crt && \
    chown -R nginx /etc/ssl/private &&\
    mkdir -p /var/www/html

WORKDIR /var/www/html

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE 443

ENTRYPOINT ["/usr/bin/dumb-init", "--", "nginx", "-g", "daemon off;"]