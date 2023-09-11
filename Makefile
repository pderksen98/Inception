PROJECT = inception

LIST_CONTAINERS := $(shell docker ps -a -q)
LIST_VOLUMES := $(shell docker volume ls -q)

all: debian up

up:
	mkdir -p /Users/pieterderksen/data/mariadb
	mkdir -p /Users/pieterderksen/data/wordpress
	sudo docker compose -f srcs/docker-compose.yaml up --build

stop:
	docker compose -f srcs/docker-compose.yaml stop

kill:
	docker compose -f srcs/docker-compose.yaml kill

reset:
	docker compose -f srcs/docker-compose.yaml down
	docker rm -f $(LIST_CONTAINERS)
	docker volume rm -f $(LIST_VOLUMES)
	rm -rf /Users/pieterderksen/data

debian: 
	docker pull debian:buster

re: reset up
