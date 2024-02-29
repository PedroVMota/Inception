if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    service mysql start
    sleep 3
    echo "CREATE DATABASE $DB_NAME;" | mysql -u root
    mysql -u root -e "CREATE DATABASE $DB_NAME;"
    mysql -u root -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_ADMIN'@'%';"
    mysql -u root -e "FLUSH PRIVILEGES;"

    mysqladmin -u root password "$DB_PASS"
    mysqladmin -u root -p"$DB_PASS" shutdown
fi

exec mysqld_safe --bind-address=0.0.0.0