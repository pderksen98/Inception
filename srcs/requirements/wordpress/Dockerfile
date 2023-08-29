FROM debian:buster

#update packeage list
RUN apt-get update
#install needed packages
RUN apt-get install -y php-fpm php-mysql wget mariadb-client

#download the wp-cli.phar file and mak it executable
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod u+x wp-cli.phar
#moves the file to the bin directory so that it can be used from anywhere
RUN mv wp-cli.phar /usr/local/bin/wp

#change the listen option in the www.conf file so that the container can be accessed from outside the container
RUN sed 's|listen = /run/php/php7.3-fpm.sock|listen = 0.0.0.0:9000|g' -i /etc/php/7.3/fpm/pool.d/www.conf
#creates the /run/php directory which is needed for the container to run
RUN mkdir -p /run/php

#copies the wp_setup.sh & wait.sh script from host to the container
COPY tools/wp_setup.sh .
COPY tools/wait.sh .
#make the scripts executable
RUN chmod +x wp_setup.shut
RUN chmod +x wait.sh

#wp_setup.sh installs WordPress, starts the php-fpm server and creates a WordPress user
#wait.sh waits for the database to be ready before starting the php-fpm server


EXPOSE 9000

ENTRYPOINT ["./wp_setup.sh"]