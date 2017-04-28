# (add /etc/hosts entry for this which points to localhost)
WEBSITE_URI := sywebsaver.local

.PHONY: install build run stop start down rm db

install:
    docker-compose exec php composer install

init:
    docker-compose build
    docker-compose up -d

run:
    docker-compose up -d
    docker-compose exec php php bin/console cache:clear

status:
    docker-machine ls
    @echo
    docker ps -a
    @echo
    docker-machine ip $(DOCKER_MACHINE)
    @echo

stop:
    docker-compose stop

start:
    docker-compose up -d

down:
    docker-compose down

rm:
    docker-compose rm
 
db:
    docker-compose exec db mysql -u root -p $(MYSQL_ROOT_PASSWORD)

bash:
    docker exec -it container_name bash