#!bin/bash

./wait.sh

mkdir -p /var/www/wordpress

if [ ! -f /var/www/wordpress/wp-config.php ]
then
	cd /var/www/wordpress #go into volume
    wp core download --allow-root
    wp config create --allow-root --dbname=$DB_NAME --dbuser=$WP_A_LOGIN --dbpass=$WP_A_PW --dbhost=mariadb --config-file=/var/www/wordpress/wp-config.php --skip-packages --skip-plugins

    echo Created config

	wp core install --allow-root --url=$WP_URL --admin_user=$WP_A_LOGIN --admin_password=$WP_A_PW --title=mywordpresssite --admin_email=pleasedonotemailme@42.fr
	wp user create $WP_U_LOGIN pleasedonotemailme2@42.fr --allow-root --user_pass=$WP_U_PW;
	chown -R www-data:www-data /var/www/wordpress
fi
echo "Wordpress started"
php-fpm7.3 -R -F #runs on the foreground as root
