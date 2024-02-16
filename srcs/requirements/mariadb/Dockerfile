# syntax=docker/dockerfile:1

FROM alpine:3.18

# 설치 - 데이터베이스에 연결하고 명령을 실행하는 등의 작업을 더 쉽게 하기 위해 client를 같이 설치, 프로세스 관리를 위해 dumb-init  설치
RUN apk update && apk add --no-cache mysql mysql-client \
	dumb-init

# 설정 적용 - 실행 디렉토리 설정, 서버 모든 IP 연결 수락 ,네트워크 연결 활성화
RUN mkdir /var/run/mysqld && \
	chmod 777 /var/run/mysqld && \
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf &&\
    sed -i "s|.*skip-networking.*|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

COPY tools/set_db.sh /home/set_db.sh

RUN chmod 777 /home/set_db.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/bin/sh", "/home/set_db.sh"]
