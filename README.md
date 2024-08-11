# Inception

<aside>
📌 This document is a System Administration related exercise.

</aside>

이 프로젝트는 Docker를 사용하여 시스템 관리에 대한 지식을 넓히는 것을 목표로 한다. 여러개의 Docker 이미지를 가상화하여 새로운 가상 머신에 생성한다.

(도커 이미지란? Docker에서 사용할  파일)

## ****General guidelines****

- 이 프로젝트는 가상 머신에서 수행해야 한다.
- 프로젝트 구성에 필요한 모든 파일은 `srcs` 폴더에 배치해야 한다.
- Makefile 도 필요하며, 디렉토리의 root에 위치해야 한다.
이 파일은 전체 애플리케이션을 설정한다. (즉, docker-compose.yml 을 사용하여 Docker 이미지를 빌드해야 한다.)
- 이 주제는 아직 배우지 않았을 수도 있는 개념을 실제로 적용해야 한다. 따라서 과제를 완료하는 데 도움이 될 만한 Docker 사용법과 관련된 많은 문서와 기타 유용한 정보를 주저하지 말고 읽어보자.

## Mandatory

이 프로젝트는 특정 규칙에 따라 다양한 서비스로 구성된 소규모 infrastructure를 설정하는 것으로 구성된다. 

(인프라란? 소프트웨어 애플리케이션을 구축하고 실행하는데 필요한 모든 것 )

전체 프로젝트는 가상 머신에서 수행해야 한다.

doker compose를 사용해야 한다.

각 Docker 이미지는 해당 서비스와 동일한 이름을 가져야 한다.

각 서비스는 전용 컨테이너에서 실행되어야 한다.

성능 문제를 위해 컨테이너는 두 번째로 안정적인 버전의 `Alpine` 또는 `Debian`으로 빌드 해야한다. 선택은 여러분의 몫!

또한 서비스당 하나씩 자체 Docker파일을 작성해야 한다. Docker파일은 Makefile에서 docker-compose.yml을 호출해야 한다.

즉, 프로젝트의 Docker 이미지를 직접 빌드해야 한다. 그런 다음 이미 만들어진 Docker 이미지를 가져오는 것은 물론 DockerHub와 같은 서비스를 사용하는 것도 금지된다. (Alpine/Debian은 이 규칙에서 제외된다.)

그런 다음 설정해야 한다.

- TLSv1.2 또는 TLSv1.3만 있는 NGINX가 포함된 Docker컨테이너
- 워드프레스 + php-fpm(설치 및 구성해야 함)이 포함된 도커 컨테이너로, nginx없이 워드프레스만 포함되어야 함.
- nginx없이 MariaDB만 포함된 Docker 컨테이너
- 워드프레스 데이터베이스가 들어있는 볼륨
- 워드프레스 웹사이트 파일이 들어 있는 두 번째 볼륨
- 컨테이너 간의 연결을 설정하는 도커 네트워크
- 충돌이 발생하면 컴테이너를 다시 시작해야 한다.

<aside>
    
    ℹ️ Docker 컨테이너는 가상머신이 아니다. 따라서 이를 실행하려고 할 때 ‘talil -f’등을 기반으로 하는 해키 패치를 사용하지 않는 것이 좋다.
    데몬의 작동 방식과 데몬을 사용하는 것이 좋은지 아닌지에 대해 읽어보자.

</aside>

<aside>
    ❗ 물론, network: host or link or links: 사용은 금지되어 있다.
    네트워크 라인은 반드시 docker-compose.yml file에 있어야 한다. 컨테이너는 무한 루프를 실행하는 명령으로 시작해서는 안된다. 
    따라서 이는 entrypoint script로 사용되거나 entrypoint script로 사용되는 모든 명령에 적용된다. 
    
    몇다음은 몇가지 금지된 해커 패치이다: tail -f, bash, sleep, infinity, while true.

</aside>


<aside>
    
    ℹ️ Read about PID 1 and the best practices for writing Dockerfiles.

</aside>

- WordPress database에는, 두 명의 사용자가 있어야 하며 그 중 한 명은 adminstrator여야한다. 관리자의 username에는 admin/Admin or administrator/Administrator 를 포함할 수 없다. (e.g., admin, adminstrator, Administrator, admin-123 등).

<aside>
    
    ℹ️ Volumes은 도커를 사용하는 host machine의 /home/login/data 폴더에서 사용할 수 있다.
    물론, 로그인 정보를 사용자 이름으로 바꿔야 한다.

</aside>

- 작업을 더 간단하게 하려면 도메인 네임이 local IP address를 가리키도록 구성해야 한다.
- 이 도메인 이름은 [login.42.fr](http://login.42.fr) 이어야 한다. 다시말하지만, 자신의 login 이름을 사용해야 한다.
- 예를 들어 아이디가 wil 인 경우 wil.42.fr은 wil의 웹사이트를 가리키는 IP address로 redirect된다.

<aside>
    
    ❗ 최신 태그는 금지된다.
    Docker 파일에 비밀번호가 없어아 햔다.
    환경 변수는 반드시 사용해야 한다. 또한, 환경 변수를 저장하는 데 .env 파일을 사용할 것을 강력히 권장한다.
    .env 파일은 srcs 디렉터리의 루트에 위치해야 한다. 
    NGINX 컨테이너는 포트 443을 통해서만 infrastructure로 들어가는 유일한 진입점이어야 하며, TLSv1.2 또는 TLSv1.3 프로토콜을 사용해야 한다.

</aside>


- 다음은 예상되는 디렉터리 구조의 예시:

```bash
$> ls -alR
total XX
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 .
drwxrwxrwt 17 wil wil 4096 avril 42 20:42 ..
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 Makefile
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 srcs

./srcs:
total XX
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 .
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 ..
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 docker-compose.yml
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 .env
drwxrwxr-x 5 wil wil 4096 avril 42 20:42 requirements

./srcs/requirements: 
total XX
drwxrwxr-x 5 wil wil 4096 avril 42 20:42 .
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 ..
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 bonus
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 mariadb
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 nginx
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 tools
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 wordpress

./srcs/requirements/mariadb:
total XX
drwxrwxr-x 4 wil wil 4096 avril 42 20:45 .
drwxrwxr-x 5 wil wil 4096 avril 42 20:42 ..
drwxrwxr-x 2 wil wil 4096 avril 42 20:42 conf
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 Dockerfile
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 .dockerignore
drwxrwxr-x 2 wil wil 4096 avril 42 20:42 tools
[...]
./srcs/requirements/nginx:
total XXdrwxrwxr-x 4 wil wil 4096 avril 42 20:42 .
drwxrwxr-x 5 wil wil 4096 avril 42 20:42 ..
drwxrwxr-x 2 wil wil 4096 avril 42 20:42 conf
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 Dockerfile
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 .dockerignore
drwxrwxr-x 2 wil wil 4096 avril 42 20:42 tools
[...]

$> cat srcs/.env
DOMAIN_NAME=wil.42.fr
# certificates
CERTS_=./XXXXXXXXXXXX
# MYSQL SETUP
MYSQL_ROOT_PASSWORD=XXXXXXXXXXXX
MYSQL_USER=XXXXXXXXXXXX
MYSQL_PASSWORD=XXXXXXXXXXXX
[...]
$>
```


<aside>

    ❗ 명백한 보안상의 이유로 모든 자격 증명(and credentials), API keys, 환경 변수 등은 .env 파일에 로컬로 저장해야하며 git에서는 무시해야 한다. 
    public으로 저장된 자격 증명을 사용하면 바로 프로젝트 failure.

</aside>
