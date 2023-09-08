# base image is debian:buster
FROM debian:buster

# updating the package lists for upgrades and new package installations
RUN apt-get update
# installing php-fpm, php-mysql, wget, mariadb-client
RUN apt-get install -y php-fpm php-mysql wget mariadb-client
# Download wp-cli.phar, make it executable, and move it to /usr/local/bin/wp
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod u+x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# modifying the PHP-FPM configuration to listen on all interfaces (0.0.0.0) on port 9000 instead of its default UNIX socket
RUN sed 's|listen = /run/php/php7.3-fpm.sock|listen = 0.0.0.0:9000|g' -i /etc/php/7.3/fpm/pool.d/www.conf
# create a directory for PHP to run in
RUN mkdir -p /run/php

# copying the wp_setup.sh & wait.sh script from the tools directory (host) to the root directory inside the container
# making them both executable
COPY tools/wp_setup.sh .
COPY tools/wait.sh .
RUN chmod +x wp_setup.sh
RUN chmod +x wait.sh

# container will listen on port 9000 (common for php-fpm)
EXPOSE 9000

# sets the entry point for the container to be the wp_setup.sh script
ENTRYPOINT ["./wp_setup.sh"]


# Packages:
# - php-fpm: PHP FastCGI Process Manager
# - php-mysql: for PHP to interact with MySQL databases
# - wget: command line tool for downloading files from the internet
# - mariadb-client: to connect to mariadb databases
# - wp-cli.phar: command line interface for WordPress