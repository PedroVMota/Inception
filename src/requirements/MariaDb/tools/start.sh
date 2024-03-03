if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ] 
then
    echo "Database already exists"
else
mysql_install_db
service mariadb start
mysql_secure_installation << EOF

n
Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
EOF
# Create database
# select user from mysql.user;

echo "================== FIRST COMMANDS =================="
echo ">>> CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
echo "================== SECOND COMMANDS =================="
echo ">>> CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
echo "================== THIRD COMMANDS =================="
echo ">>> GRANT ALL PRIVILEGES ON $MYSQL_USER.* TO '$MYSQL_PASSWORD'@'%';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
echo "================== FORTH COMMANDS =================="
echo ">>>  $MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
echo "===================================================="


echo "================== FIRST COMMANDS =================="
echo ">>> CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
echo "================== SECOND COMMANDS =================="
echo ">>> CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
echo "================== THIRD COMMANDS =================="
echo ">>> GRANT ALL PRIVILEGES ON $MYSQL_USER.* TO '$MYSQL_PASSWORD'@'%';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
echo "================== FORTH COMMANDS =================="
echo ">>>  $MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
echo "===================================================="


sleep 5
service mariadb stop
fi
# Replace current shell process to mysqld_safe and accept connections from all
exec mysqld_safe --bind-address=0.0.0.0
#if the exit status is diferent than 0, the container should keep running by using the command "tail -f /dev/null"