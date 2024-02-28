cd ngix_tsl


if [[ $1 == "delete" ]]; then
    docker stop $(docker ps -aq)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
    docker-compose down --remove-orphans
    docker-compose down --remove-orphans
    docker-compose up --build
fi
