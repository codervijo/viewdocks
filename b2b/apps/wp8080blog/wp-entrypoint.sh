#!/bin/bash
echo "Hello from inside Lamill Wordpress docker container"

DBNAME="wpdb"
DBUSER="wpuser"
DBPASS="userpasswd"
SITEADMIN="admin"
ADMINPASS="admin123"
SUBDIR="blog"

if [ -e "/root/imgb4install" ]; then
	echo "First time run, installing wordpress for ${SITEURL}"
	service mysql start
	mysqladmin password 'root'
	mysql -u root --password='root' -e "CREATE USER '${DBUSER}' IDENTIFIED BY '${DBPASS}';"
	mysql -u root --password='root' -e "CREATE DATABASE ${DBNAME};"
	mysql -u root --password='root' -e "GRANT ALL ON ${DBNAME}.* TO '${DBUSER}';"
	mysql -u root --password='root' -e "FLUSH PRIVILEGES"

    #cp /etc/apache2/sites-available/default /etc/apache2/sites-available/${SITEURL}

    cat >/etc/apache2/sites-available/${SITEURL}.conf <<EOCONF
<Directory /var/www/html/${SUBDIR}:8080>
    AllowOverride All
</Directory>
<Directory /var/www/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
<VirtualHost ${SITEURL}>
    ServerAdmin webmaster@localhost
    ServerName ${SITEURL}
    DocumentRoot /var/www/html/${SUBDIR}
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOCONF

	(cd /var/www/html/${SUBDIR} && /usr/local/bin/wp core    config   --allow-root --dbname=${DBNAME} --dbuser=${DBUSER} --dbpass=${DBPASS})
	(cd /var/www/html/${SUBDIR} && /usr/local/bin/wp core    install  --allow-root --url=tester.lamill.io:8080 --title="Lamill Websystems" --admin_user=${SITEADMIN} --admin_password=${ADMINPASS} --admin_email=vik@lamill.us)
	(cd /var/www/html/${SUBDIR} && /usr/local/bin/wp option  update siteurl --allow-root $(wp option --allow-root get siteurl)/${SUBDIR})
	(cd /var/www/html/${SUBDIR} && /usr/local/bin/wp option  update home    --allow-root $(wp option --allow-root get home)/${SUBDIR})
	(cd /var/www/html/${SUBDIR} && /usr/local/bin/wp rewrite structure --allow-root '/%postname%/')

	chown -R www-data:www-data /var/www/html/

	sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
    a2ensite ${SITEURL}

	a2enmod rewrite
    service apache2 restart
	rm -f /root/imgb4install
	echo "Completed Lamill Wordpress installation"
	/bin/bash # XXX : hack to make run -d  wait forevah
fi

exec "$@"
