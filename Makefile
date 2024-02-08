#DBVOL = /home/hyecheon/data/dbvolume
#WPVOL = /home/hyecheon/data/wpvolume
DOCKER_ID := $(shell docker ps -aq)
DOCKER_IMAGE_ID := $(shell docker images -q)
DOCKER_VOLUME := $(shell docker volume ls -q)

all:
	#mkdir -p ${DBVOL}
	#mkdir -p ${WPVOL}
	docker compose -f srcs/compose.yaml up -d

#local:

up:
	docker compose -f srcs/compose.yaml up -d

down:
	docker compose -f srcs/compose.yaml down

fclean: down
	#rm -rf ${DBVOL}
	#rm -rf ${WPVOL}
	$(if $(DOCKER_ID), docker rm -f $(DOCKER_ID))
	$(if $(DOCKER_IMAGE_ID), docker rmi $(DOCKER_IMAGE_ID))
	$(if $(DOCKER_VOLUME), docker volume rm $(DOCKER_VOLUME))
#	docker rmi nginx
#	docker rmi mriadb
#	docker rmi wordpress
#	docker volume rm srcs_db-volume
#	docker volume rm srcs_wp-volume
#   docker network rm srcs_hyecheon-network



re: fclean all

.PHONY: all up down clean local