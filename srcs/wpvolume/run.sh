#!/bin/sh

apk add openssl
mkdir -p /etc/ssl/private/
openssl genrsa -out /etc/ssl/private/hyecheon.42.fr.key 2048
openssl req -new -key /etc/ssl/private/hyecheon.42.fr.key -out /etc/ssl/private/hyecheon.42.fr.crt -subj "/C=KR/ST=Seoul/L=Gaepodong/O=42seoul/OU=Cadet/CN=hyecheon.42.fr"
openssl x509 -req -days 1000 -in /etc/ssl/private/hyecheon.42.fr.crt -signkey /etc/ssl/private/hyecheon.42.fr.key -out /etc/ssl/private/hyecheon.42.fr.crt
chown -R nginx /etc/ssl/private/
rm /etc/nginx/conf.d/default.conf
cp /home/default.conf /etc/nginx/conf.d/default.conf
nginx -s reload