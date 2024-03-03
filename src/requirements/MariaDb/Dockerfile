FROM debian:11

RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

COPY ./requirements/MariaDb/tools/start.sh .

COPY ./requirements/Wordpress/conf/wp-config.php /var/www/html/
RUN chmod 777 /start.sh

EXPOSE 3306

CMD ["bash", "start.sh"]