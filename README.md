# infinidb-docker

run:
docker run -d -P -p 3307:3306 --name infinidb-docker noamguy/infinidb-docker

run interactive:
docker run -p 3307:3306 -t -i --name infinidb-docker noamguy/infinidb-docker

shell:
docker exec -i -t infinidb-docker /bin/bash

connect to infinidb:
docker exec -i -t infinidb-docker /usr/local/Calpont/mysql/bin/mysql --defaults-file=/usr/local/Calpont/mysql/my.cnf -u root
