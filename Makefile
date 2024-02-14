DBVOL = /home/hyecheon/data/dbvolume
WPVOL = /home/hyecheon/data/wpvolume
#DBVOL = /Users/hyecheon/dbvolume
#WPVOL = /Users/hyecheon/wpvolume
ID := $(shell docker ps -aq)
IMAGE := $(shell docker images -q)
VOLUME := $(shell docker volume ls -q)

all:
	 mkdir -p ${DBVOL}
	 mkdir -p ${WPVOL}
	docker compose -f srcs/compose.yaml build --no-cache
	docker compose -f srcs/compose.yaml up -d

up:
	docker compose -f srcs/compose.yaml up -d

down:
	docker compose -f srcs/compose.yaml down

fclean: down
	rm -rf ${DBVOL}
	rm -rf ${WPVOL}
	$(if $(ID), docker rm -f $(ID))
	$(if $(IMAGE), docker rmi $(IMAGE))
	$(if $(VOLUME), docker volume rm $(VOLUME))


re: fclean all

.PHONY: all up down clean