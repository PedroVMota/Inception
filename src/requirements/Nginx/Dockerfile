# Start from the alpine-based Nginx image
FROM alpine


# Update the package list and install openssl and nginx
RUN apk update && apk add openssl nginx

# Copy the Nginx configuration file
COPY ./Nginx/conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /etc/nginx/ssl
# Generate a self-signed certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=42/CN=pvital-"

# Expose the port
EXPOSE 443



# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]