DBVOL = /home/hyecheon/data/dbvolume
WPVOL = /home/hyecheon/data/wpvolume

all:
	mkdir -p ${DBVOL}
	mkdir -p ${WPVOL}


local:

up:
	docker compose -f srcs/compose.yaml up -d

down:
	docker compose -f srcs/compose.yaml down

re: fclean
	make all

fclean:
	rm -rf ${DBVOL}
	rm -rf ${WPVOL}

.PHONY: all up down clean local