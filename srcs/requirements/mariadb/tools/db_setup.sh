#!bin/bash

if [ ! -d /run/mysqld ] #checks if the database is not already set up
then

	echo "Setting up MariaDB"

	# Create the run directory for mysqld
	mkdir -p /run/mysqld
	# chown command changes the ownership of files/directories
	# it's setting both the owner and group of /run/mysqld and /var/lib/mysql to mysql 
	 the -R option makes this change recursively for every file and directory inside the specified path
	chown -R mysql:mysql /run/mysqld
	chown -R mysql:mysql /var/lib/mysql

	# this is a script that initializes the MariaDB/MySQL database
	# the --basedir specifies the base directory, and the --datadir specifies the directory for the database files
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql #initializes database

# Creates a temporary file to store the SQL commands to be executed, creates the database and the users
cat << EOF > init.sql
	USE mysql;
	FLUSH PRIVILEGES;

	DELETE FROM mysql.user WHERE User='';
	DROP DATABASE test;
	DELETE FROM mysql.db WHERE Db='test';

	ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PW';

	CREATE DATABASE IF NOT EXISTS $DB_NAME;

	CREATE USER '$WP_A_LOGIN'@'%';
	SET PASSWORD FOR '$WP_A_LOGIN'@'%' = PASSWORD('$WP_A_PW');
	GRANT ALL PRIVILEGES ON wordpress.* TO '$WP_A_LOGIN'@'%';
	GRANT ALL ON wordpress.* to '$WP_A_LOGIN'@'%';
	FLUSH PRIVILEGES;

	CREATE USER '$WP_U_LOGIN'@'%';
	SET PASSWORD FOR '$WP_U_LOGIN'@'%' = PASSWORD('$WP_U_PW');
EOF

# This starts the mysqld process (the MariaDB server) with the mysql user 
# The --bootstrap option is used to start the server in an "initialize-only" mode, which runs the commands from init.sql.
mysqld --user=mysql --bootstrap < init.sql

fi

echo "MariaDB started"

#starts database server in foreground (--console)
# exec command replaces the current shell process with the specified command (in this case, mysqld)
exec mysqld --user=mysql --console 

# script essentially helps to:
# - set up and start the MariaDB server,
# - ensuring that necessary directories exist, 
# - database is initialized, 
# - proper users and permissions are created, 
# - the server is started in the foreground
