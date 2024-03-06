#Check if the database exists:
#The script first checks if the directory /var/lib/mysql/$MYSQL_DATABASE exists.
#This directory is where MySQL stores the data for the database named $MYSQL_DATABASE.
#If this directory exists,
#the script prints "Database already exists" and skips the rest zof the initialization.
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ] 
then
    echo "Database already exists"
else
#Initialize the database: If the database does not exist, the script initializes the MySQL data directory with mysql_install_db and starts the MariaDB service.
mysql_install_db

#Start the MariaDB service
service mariadb start


#Secure the installation: The script then runs mysql_secure_installation to secure the MySQL installation. 
#This includes setting the root password, removing anonymous users, disallowing root login remotely, and removing the test database.
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
#Create the database and user: The script creates the database and user specified by the $MYSQL_DATABASE, $MYSQL_USER, and $MYSQL_PASSWORD environment variables.
#It also grants all privileges on the database to the user.
mysql -u $MYSQL_ROOT_USER -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -u $MYSQL_ROOT_USER -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u $MYSQL_ROOT_USER -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mysql -u $MYSQL_ROOT_USER -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"


sleep 5
service mariadb stop
fi
# Replace current shell process to mysqld_safe and accept connections from all
exec mysqld_safe --bind-address=0.0.0.0
#if the exit status is diferent than 0, the container should keep running by using the command "tail -f /dev/null"