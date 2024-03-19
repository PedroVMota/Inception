FROM debian:bullseye

# install the software to the system
RUN apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

# Create the mysqlfolder and set the right permissions
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld 
RUN chmod 777 /var/run/mysqld

# Copy the start.sh file to the container
COPY ./tools/start.sh .

# Set the right permissions to the start.sh file
RUN chmod 777 /start.sh

# Expose the port 3306
EXPOSE 3306

# Start the container with the start.sh file
CMD ["bash", "start.sh"]
