if [[ $1 == "delete" ]]; then
    docker stop $(docker ps -aq) 2> /dev/null 2> /dev/null
    docker rm $(docker ps -a -q) 2> /dev/null 2> /dev/null
    docker rmi $(docker images -q) 3> /dev/null 2> /dev/null
    docker volume rm $(docker volume ls -q) 2> /dev/null 2> /dev/null

    exit 0
fi


docker-compose down --remove-orphans
docker-compose up  --build 

# open https://localhost:443