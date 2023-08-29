FROM debian:buster

Run apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server mariadb-client nano

COPY tools/db_setup.sh /tmp/

#makes setup script executable
RUN chmod +x /tmp/db_setup.sh

#changes the bind address, meaning that the server will listen to all incoming connections
RUN sed 's/bind-address = 127.0.0.1/bind-address = 0.0.0.0/' -i etc/mysql/mariadb.conf.d/50-server.cnf
#removes the skip-networking line, so that the database can be accessed from outside the container
RUN sed 's/skip-networking/#skip-networking/' -i etc/mysql/mariadb.conf.d/50-server.cnf

#The square brackets around the path instructs the entrypoint to execute the script with exec rather than sh.
#The exec command replaces the current process with the new process, i.e. PID 1. 
#This is important as it allows the container to receive signals from the host and properly shut down.
ENTRYPOINT ["/tmp/db_setup.sh"]