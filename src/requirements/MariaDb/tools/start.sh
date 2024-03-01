# if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
#     echo "Starting MariaDB"
#     service mariadb start
#     touch /DIDIT
#     sleep 3
#     echo "CREATE DATABASE $MYSQL_DATABASE;" | mysql -u root
#     mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE;"
#     echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_DATABASE';"
#     mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_DATABASE';"
#     echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.*"
#     mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_ADMIN'@'%';"
#     echo "FLUSHING PRIVILEGES;"
#     mysql -u root -e "FLUSH PRIVILEGES;"
#     mysqladmin -u root password "$MYSQL_DATABASE"
#     mysqladmin -u root -p"$MYSQL_DATABASE" shutdown
# else
#     touch /DIDNOT
#     service mariadb start
#     sleep 3
#     mysqladmin -u root password "$MYSQL_DATABASE"
#     mysqladmin -u root -p"$MYSQL_DATABASE" shutdown
# fi

# # exec mysqld_safe --bind-address=0.0.0.0


#!/bin/bash



service mysql start 


echo "CREATE DATABASE IF NOT EXISTS $db1_name ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;" >> db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld