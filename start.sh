if [[ $1 == "delete" ]]; then
    docker stop $(docker ps -aq)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
    exit 0
fi


docker-compose down --remove-orphans
docker-compose up  --build 

# open https://localhost:443