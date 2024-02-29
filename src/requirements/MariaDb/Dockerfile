# Selecting the base image
FROM debian:bullseye

# Installing the required packages
RUN apt-get update -y && apt-get install mariadb-server -y

#Start the deamon of sql
RUN mkdir -p /var/run/mysqld

# making sure that the folder is owned by the mysql user
RUN chown -R mysql:mysql /var/run/mysqld

# RUN ls -la /var/run/mysqld

# Copy the configuration file
COPY ./requirement/MariaDb/conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copy the script that will start the server
# COPY ./MariaDb/tools/start.sh /tmp/start.sh

# Expose the port
EXPOSE 3306

COPY ./requirements/MariaDb/tools/start.sh start.sh


ENTRYPOINT ["sh", "start.sh"]

