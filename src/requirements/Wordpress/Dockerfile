FROM debian:buster


# Install the required packages
RUN apt update && apt install -y php php-curl php-fpm php-bcmath php-gd php-soap php-zip php-curl php-mbstring php-mysqlnd php-gd php-xml php-intl php-zip

RUN apt install curl -y

COPY ./requirements/Wordpress/tools/start.sh /start.sh

COPY ./requirements/Wordpress/tools/wp-config.php /wp-config.php

# setup www.conf
COPY ./requirements/Wordpress/tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf

CMD ["sh", "/start.sh"]