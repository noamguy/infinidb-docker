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
RUN apt-get -y install bison flex
RUN apt-get -y install wget

RUN mkdir infinidb-src

RUN cd infinidb-src
RUN echo Downloading infinidb-mysql
RUN wget -Omysql-4.6.2-1.tar.gz https://github.com/infinidb/mysql/archive/4.6.2-1.tar.gz
RUN tar -zxf mysql-4.6.2-1.tar.gz
RUN ln -s mysql-4.6.2-1 mysql

RUN echo Downloading infinidb
RUN wget -Oinfinidb-4.6.2-1.tar.gz https://github.com/infinidb/infinidb/archive/4.6.2-1.tar.gz
RUN tar -zxf infinidb-4.6.2-1.tar.gz
RUN ln -s infinidb-4.6.2-1 infinidb

RUN echo installing infinidb-mysql
RUN cd infinidb-src
RUN cd ./mysql&&./configure --prefix=$HOME/infinidb/mysql&&make&&make install

RUN echo installing infinidb
RUN cd infinidb-src
RUN cd infinidb&&./configure --prefix=$HOME/infinidb&&make&&make install

RUN mv ./root/infinidb /usr/local/Calpont
RUN touch /etc/ld.so.conf.d/infinidb.conf
RUN echo /usr/local/Calpont/lib > /etc/ld.so.conf.d/infinidb.conf && echo /usr/local/Calpont/mysql/lib/ >> /etc/ld.so.conf.d/infinidb.conf && echo /usr/local/Calpont/mysql/lib/mysql/ >> /etc/ld.so.conf.d/infinidb.conf
RUN ldconfig
RUN cp /usr/local/Calpont/etc/Calpont.xml.singleserver /usr/local/Calpont/etc/Calpont.xml.rpmsave
RUN /usr/local/Calpont/bin/post-install
RUN /usr/local/Calpont/bin/postConfigure -n -s
RUN /usr/local/Calpont/bin/calpontAlias

RUN echo installing supervisor
RUN apt-get -y install supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY infinidb_non_demonized_healper.sh .

EXPOSE 3306

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
