FROM	debian:buster

RUN     apt-get update -y && \
		apt-get install mariadb-server -y

RUN		mkdir -p /var/run/mysqld && mkdir -p /run/mysqld
RUN     chown -R mysql:root /run/mysqld && chown -R mysql:root /var/run/mysqld


COPY	./requirements/MariaDb/tools/start.sh /start.sh
COPY	./requirements/MariaDb/conf/mariadb-server.cnf /etc/mysql/my.cnf

EXPOSE 3306

RUN chmod +x /start.sh

CMD		["bash", "/start.sh"]