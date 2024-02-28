# Start from the alpine-based Nginx image
FROM alpine

# Update the package list and install openssl and nginx
RUN apk update && apk add openssl nginx

RUN mkdir -p /etc/nginx/ssl
# Generate a self-signed certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=ftorres"

# Copy the configuration file and the HTML file
COPY ./nginxTsl/html/index.html /usr/share/nginx/html/index.html

# Expose the port
EXPOSE 443
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]