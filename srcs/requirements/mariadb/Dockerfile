# sets the base image for the container as debian:buster
FROM debian:buster

# updating the package lists for upgrades and new package installations && upgrading the installed packages
RUN apt-get update && apt-get upgrade -y
# installing mariadb-server, mariadb-client
RUN apt-get install -y mariadb-server mariadb-client

# copies the db_setup.sh script from the tools directory on host to the /tmp/ directory inside the container
COPY tools/db_setup.sh /tmp/
# making the db_setup.sh script executable
RUN chmod +x /tmp/db_setup.sh

# using sed to modify the MariaDB configuration:
# change the bind-address to 0.0.0.0 to allow connections from any IP address
RUN sed 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/' -i  /etc/mysql/mariadb.conf.d/50-server.cnf
# comment out the skip-networking line to allow network-based connections
RUN sed 's/skip-networking/#skip-networking/g' -i  /etc/mysql/mariadb.conf.d/50-server.cnf 

# sets the entry point for the container to be the db_setup.sh script
# this script will be executed when the container starts
ENTRYPOINT ["/tmp/db_setup.sh"]


# Packages:
# - mariadb-server: 
# - mariadb-client: 