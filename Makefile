PROJECT = inception

LIST_CONTAINERS := $(shell docker ps -a -q)
LIST_VOLUMES := $(shell docker volume ls -q)

all: up

up:
	mkdir -p /home/pderksen/data/mariadb
	mkdir -p /home/pderksen/data/wordpress
	docker-compose -f src/docker-compose.yml up --build

stop:
	docker-compose -f src/docker-compose.yml stop

kill:
	docker-compose -f src/docker-compose.yml kill

reset:
	docker-compose -f src/docker-compose.yml down
	docker rm -f $(LIST_CONTAINERS)
	docker volume rm -f $(LIST_VOLUMES)
	rm -rf /home/pderksen/data

re: reset up

# - up: makes two directories for the database and wordpress files, ....
# ..... and then starts calls docker-compose up to start the containers
# - stop: calls docker-compose stop to stop the containers
# - kill: calls docker-compose kill to kill the containers
# - reset: calls docker-compose down to remove the containers, then removes all ....
# ..... containers and volumes, and finally removes the two directories for the database and wordpress files
# - re: calls reset and then up
