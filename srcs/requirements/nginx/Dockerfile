FROM debian:buster

#update packeage list and install packages
RUN apt-get update
RUN apt-get install -y nginx openssl curl
#this package is needed to run the wp-cli.phar file
RUN apt-get -y install libfcgi0ldbl

#copy configuration file and start.sh from the host to the container
COPY conf/nginx.conf /etc/nginx/sites-available/default.conf
COPY start.sh .
#makes start.sh executable
RUN chmod +x start.sh

#ln is used to create symbolic link from configuration file to the sites-enabled directory
#This is needed so that the configuration file is used by nginx
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

EXPOSE 443

#as like in the wordpress and mariadb containers, the entrypoint is execture with exec rather than sh
ENTRYPOINT [ "./start.sh" ]
