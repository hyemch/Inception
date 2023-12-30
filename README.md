# Inception

<aside>
📌 This document is a System Administration related exercise.

</aside>

- PDF
    
    https://cdn.intra.42.fr/pdf/pdf/115394/en.subject.pdf
    

![스크린샷 2023-12-30 오후 4.32.12.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/969d3a9e-6112-4b99-a4bb-b6e48dbc2d34/731e9595-d5b6-42fe-bef9-186d5b926222/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-12-30_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_4.32.12.png)

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
ℹ️ Docker 컨테이너는 가상머신이 아니다. 따라서 이를 실행하려고 할 때 ‘talil -f’등을 기반으로 하는 해킹 패치를 사용하지 않는 것이 좋다. 데몬의 작동 방식과 데몬을 사용하는 것이 좋은지 아닌지에 대해 읽어보자.

</aside>

-
