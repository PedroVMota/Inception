include .env
export 

all: build

build:
	docker-compose up -d --build

down:
	docker-compose down

clear:
	docker-compose down -v
	docker rmi $(shell docker images -q) -f