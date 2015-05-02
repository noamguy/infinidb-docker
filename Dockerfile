FROM ubuntu

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install build-essential
RUN apt-get -y install g++
RUN apt-get -y install expect
RUN apt-get -y install zlib1g-dev
RUN apt-get -y install libncurses5-dev
RUN apt-get -y install libxml2-dev
RUN apt-get -y install libreadline6
RUN apt-get -y install libreadline6-dev
RUN apt-get -y install wget

RUN mkdir infinidb-src
RUN cd infinidb-src

RUN wget -Omysql-4.6.2-1.tar.gz https://github.com/infinidb/mysql/archive/4.6.2-1.tar.gz
RUN tar -zxf mysql-4.6.2-1.tar.gz
RUN ln -s mysql-4.6.2-1 mysql
RUN cd ./mysql&&./configure --prefix=$HOME/infinidb/mysql&&make&&make install

RUN cd infinidb-src
RUN wget -Oinfinidb-4.6.2-1.tar.gz https://github.com/infinidb/infinidb/archive/4.6.2-1.tar.gz
RUN tar -zxf infinidb-4.6.2-1.tar.gz
RUN ln -s infinidb-4.6.2-1 infinidb
RUN cd infinidb&&./configure --prefix=$HOME/infinidb&&make&&make install

EXPOSE 3066
CMD [ "service infinidb start" ]
