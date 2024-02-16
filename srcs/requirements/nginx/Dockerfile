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


# 컨테이너가 시작될 때 실행될 명령 지정 -> dumb-init을 사용하여 nginx를 시작하고, 데몬모드로 실행
# dumb-init: pid1 프로세스로서의 역할을 수행. 시그널을 처리하고 자식프로세스를 관리 -> 컨에이너의 종료 시그널 처리 문제를 해결할 수 있다.
# dumb-init을 사용하지 않으면 PID 1인 메인 프로세스가 종료되면 컨테이너는 즉시 종료된다.
# 예를 들면 dumb-init을 사용하지 않고 NGINX와 PHP-FPM을 직접 실행한다면, NGINX가 종료되면 컨테이너도 함께 종료된다.
# 웹 서버가 다운될 때 PHP 서비스도 함께 중단되는 불상사를 초래할 수 있다.
# -g daemon off 옵션을 사용하여 nginx 웹 서버를 foreground 모드로 실행
# daemon으로 실행 될 경우 초기 프로세스는 일부 워커 프로세스를 생성한 후 중지하게 되는데 이때 작업이 종료된 것으로 인식하고 컨테이너를 중지하게 된다.