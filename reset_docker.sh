docker stop $(docker ps -a -q)
docker kill $(docker ps -a -q)
docker rm $(docker ps -a -q)
