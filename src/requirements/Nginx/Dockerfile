# Start from the alpine-based Nginx image
FROM    debian:bullseye

# # Update the package list and install openssl and nginx
RUN     apt-get update
RUN     apt-get install nginx openssl libssl-dev wget -yq

# # Copy the Nginx configuration file
RUN rm -rf /etc/nginx/conf.d/nginx.conf
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl
# Generate a self-signed certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=42/CN=pvital-"

RUN mkdir -p /var/log/nginx/pvital-m/
RUN mkdir -p /var/log/nginx/pvital-m/


# # Expose the port
EXPOSE 443

COPY ./tools/start.sh /start.sh

# # Start the Nginx server
ENTRYPOINT ["bash", "start.sh"]


