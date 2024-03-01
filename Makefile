all:
	@docker-compose -f ./src/docker-compose.yml up -d --build

down:
	@docker-compose -f ./src/docker-compose.yml down

re:
	@docker-compose -f ./src/docker-compose.yml down
	@docker-compose -f ./src/docker-compose.yml up -d --build

volumes:
	mkdir -p ./src/wp_data;
	mkdir -p ./src/db_data;

clean:
	- docker stop $$(docker ps -a -q)
	- docker rm $$(docker ps -a -q)
	- docker rmi $$(docker images -q)
	- docker volume rm $$(docker volume ls -q)
	- docker network rm $$(docker network ls -q)
	- sudo rm -rf ./src/wp_data/*; sudo rm -rf ./src/db_data/*;