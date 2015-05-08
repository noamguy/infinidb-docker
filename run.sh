./reset_docker.sh
docker run -d -P -p 3307:3306 --name infinidb-docker local-infinidb-docker
