FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	mariadb-server mariadb-client

WORKDIR /tmp

COPY ./tools/* .
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT ["./setUpDB.sh"]

CMD ["mysqld"]