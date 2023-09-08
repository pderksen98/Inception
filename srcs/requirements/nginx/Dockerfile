# sets the base image for the container as debian:buster
FROM debian:buster

# updating the package lists for upgrades and new package installations
RUN apt-get update
# installing nginx, openssl, curl, libfcgi0ldbl
RUN apt-get install -y nginx openssl curl
RUN apt-get -y install libfcgi0ldbl

# copying the custom nginx.conf to the container's /etc/nginx/sites-available/ directory and naming it default.conf
COPY conf/nginx.conf /etc/nginx/sites-available/default.conf
# copy start.sh script to the root directory of the container
COPY start.sh .
# making the start.sh script executable
RUN chmod +x start.sh

# ln is used to create symbolic link from configuration file to the sites-enabled directory
# this is needed so that the configuration file is used by nginx
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf
#openssl is used to generate the certificate and key files that are used in the configuration file
#the -nodes option is used to make the cerftificate and key file not password protected
#the -newkey option is used to specify the type of key to generate
#the -keyout option is used to specify the path of the key file
#the -out option is used to specify the path of the certificate file
#the -subj option is used to specify the subject of the certificate
#the subject is the formation that is displayed when you click on the lock icon in the browser
#the subject is set to pderksen.42.fr as required by the subject
RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/nginx/key.key -out /etc/nginx/crt.crt -subj "/CN=pderksen.42.fr"

# container will listen on port 443 (common for https)
EXPOSE 443

# sets the entry point for the container to be the start.sh script
ENTRYPOINT [ "./start.sh" ]

# Packages:
# - nginx: server
# - openssl: SSL/TLS operations
# - curl: command line tool for transferring data with URL syntax
# - libfcgi0ldbl: FastCGI library
