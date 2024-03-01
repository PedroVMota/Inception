echo "DATABASE: ${MYSQL_DATABASE}"
ls /var/lib/mysql | tr "\n" " "
echo "\n\n"
if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
    echo "Database ${MYSQL_DATABASE} not found. Creating..."
    echo "\n\n"
    mysqld&
    until mysqladmin ping; do
        sleep 2
    done
    echo "\n\n"
    mysql -u root -e "CREATE DATABASE ${MYSQL_DATABASE};"
    mysql -u root -e "CREATE USER '${MYSQL_ROOT_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -u root -e "GRANT ALL ON *.* TO '${MYSQL_ROOT_USER}'@'%';"
    mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -u root -e "FLUSH PRIVILEGES;"
    killall mysql
else
    echo "Database ${MYSQL_DATABASE} found."
fi

mysqld