# Inception

This project from 42 School aims to broaden your knowledge of system administration by using Docker. In this tutorial, you will virtualize several Docker images, creating them in your new personal virtual machine. This README provides an inception tutorial to help you understand how the project works.

## Important Things to Read Before Beginning the Project

1. **Don't try to create all the containers** (Nginx, WordPress, and MariaDB) at the same time.
You might get overwhelmed and not fully understand how it works. Take it step by step.

2. **Start with Nginx** by displaying an index.html page.
	- First, learn how to launch a Docker image and execute it **without using docker-compose**.
	- Learn how to display an HTML page on `http://localhost:80`.
	- Learn how to display an HTML page with SSL on `https://localhost:443`.

3. **Move on to WordPress.**
	- At this point, you can begin using the docker-compose file. You don't need it before.

4. **Finish with MariaDB.**

Want to check if each container works individually? No worries, you can do this by importing WordPress and MariaDB images from Docker Hub. (If this is your first time reading this, I encourage you to continue with this README and give it a star! It helps!)

# SUMMARY

1. [DEFINITIONS](#definitions)
2. [DOCKER](#docker)
3. [NGINX](#nginx)
4. [WORDPRESS](#wordpress)
5. [MARIADB](#mariadb)

# Definitions

## What is Docker?
Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure the same way you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the time between writing code and running it in production.
Docker provides the ability to package and run an application in a loosely isolated environment called a container.

## What is Docker Compose?
[What is Docker in general?](https://www.educative.io/blog/docker-compose-tutorial)
[What is Docker networking?](https://www.aquasec.com/cloud-native-academy/docker-container/docker-networking/)
Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

## What is a Dockerfile?
Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using `docker build`, users can create an automated build that executes several command-line instructions in succession.

## How to Install Docker on macOS
For this project, I am using my personal Mac, so I don't need to use a virtual machine to run sudo commands. To install Docker, follow these steps:
- Go to the Docker website and download Docker [Link to the website](https://docs.docker.com/desktop/install/mac-install/).
- Install Docker on your machine.
- Test the installation by running a Dockerfile using the command `docker run hello-world`.

## Useful Things to Know About Inception, Docker, and Containers
- On a Mac, the Apache service is installed by default. I removed Apache from my computer to avoid any conflicts with Nginx.
- If you are at 42 School and using their computers, you should stop these services, which run by default:
```bash
sudo service nginx stop
sudo service mariadb stop
sudo service apache2 stop
sudo service mysql stop
```

# DOCKER

## Important Commands for Using Docker
- [Best practices for building containers](https://cloud.google.com/architecture/best-practices-for-building-containers)

### General Docker Commands
```bash
- docker ps or docker ps -a # Shows the names of all containers you have, along with their IDs and associated ports.
- docker pull "NameOfTheImage" # Pulls an image from Docker Hub.
- docker logs "ContainerNameOrID" # Displays the logs of the specified container.
- docker rm $(docker ps -a -q) # Deletes all stopped containers.
- docker exec -it "ContainerNameOrID" sh # Executes a shell inside the specified container.
```

### Docker Run

```bash
- docker run "ImageName" # Runs the specified Docker image.
- docker run -d # Runs the container in the background.
- docker run -p # Publishes a container's port to the host.
- docker run -P # Publishes all exposed ports to random ports.
- docker run -it "ImageName" # The program will continue to run, and you can interact with the container.
- docker run --name "ContainerName" mysql # Assigns a name to the container instead of an ID.
- docker run -d -p 7000:80 test:latest
```

### Docker Image
```bash
- docker image rm -f "ImageNameOrID" # Deletes the image; if the image is running, you need to stop it first.
- docker image kill "ContainerNameOrID" # Stops a running image.
```

## How to Write a Dockerfile
- Create a file named `Dockerfile`.
- Write your commands inside the document.
- Build the Dockerfile with the command `docker build -t "YourChosenName" .`.
- Execute the Dockerfile with the command `docker run "YourChosenName"`.

Here are the most common types of instructions:

- **FROM <image>** - Defines a base for your image. Example: `FROM debian`.
- **RUN <command>** - Executes any commands in a new layer on top of the current image and commits the result. RUN also has a shell form for running commands.
- **WORKDIR <directory>** - Sets the working directory for any `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, and `ADD` instructions that follow it in the Dockerfile.
- **COPY <src> <dest>** - Copies new files or directories from `<src>` and adds them to the filesystem of the container at the path `<dest>`.
- **CMD <command>** - Defines the default program that runs once you start the container based on this image. Each Dockerfile should have only one CMD, and only the last CMD is respected if multiple exist.

## How to Launch a Localhost Webpage for Testing
### **(This point works only on a Mac, not the VM)**
### [Watch this Video Tutorial](<https://www.youtube.com/watch?v=F2il_Mo5yww&ab_channel=linuxxraza>)
- Create an HTML file with some code in it.
- Create your Dockerfile:
	- The image will be NGINX: `FROM nginx`.
	- Use `COPY` to copy your files into the HTML directory on Nginx.
- Use the command `docker build -t simple .`.
- Use the command `docker container run --name="YourChosenName" -d -p 9000:80 simple`.
	- `--name` gives a name to your container.
	- `-d` runs the container in the background.
	- `-p` publishes the container's port to the host (in this case, 9000 to 80).

# NGINX

## How to Set Up NGINX (Our Web Server)
- [Video Tutorial](<http://nginx.org/en/docs/beginners_guide.html>)
Nginx is a web server that stores HTML, JS, and image files and uses HTTP requests to display a website.
Nginx configuration files will be used to set up our server and the correct proxy connection.

## Configuring the .conf File on Nginx
### Useful Nginx Links
- [Location Explanations](<https://www.digitalocean.com/community/tutorials/nginx-location-directive>)
- [What is a Proxy Server?](<https://www.varonis.com/fr/blog/serveur-proxy>)
- [All Nginx Definitions](<http://nginx.org/en/docs/http/ngx_http_core_module.html>)
- [Nginx Command Line](<https://www.nginx.com/resources/wiki/start/topics/tutorials/commandline/>)
- [PID 1 Signal Handling and Nginx](https://cloud.google.com/architecture/best-practices-for-building-containers#signal-handling)
- [What is TLS? (In French)](https://fr.wikipedia.org/wiki/Transport_Layer_Security)

### Listen and Location Directives
- **Listen**: Specifies which requests the server should accept.
	- Example: `listen 80;` indicates that the server should listen on port 80.
- **Location**: The location directive within the Nginx server block allows routing requests to the correct location within the filesystem.
	- It tells Nginx where to look for a resource by including files and folders that match a location block against a URL.

## Steps to Add a Localhost by Configuring Nginx
### **(This point works only on a Mac, not the VM)**
1. I added an `index.html` file to my `/var/www/` directory.
2. I configured the default file in `/etc/nginx/sites-enabled/default`.
3. I added a server block with a location pointing to `/var/www/` in the document. Saved it and reloaded Nginx with `nginx -s reload`.
4. Since the

 port host I configured was 443, I went to a web browser and entered: `https://localhost:443/`. It worked!

## How to Change Your Localhost to `<yourlogin>.42.fr`
1. Go to the file `/etc/hosts`.
2. Add the following line: `127.0.0.1 <yourlogin>.42.fr`.

## FastCGI (or How to Process PHP with Nginx)
### Useful Links
- [What is HTTP?](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol)
- [Difference Between HTTP and TCP](https://www.goanywhere.com/blog/http-vs-tcp-whats-the-difference#:~:text=TCP%20contains%20information%20about%20what,data%20in%20the%20stream%20contains.)
- [PHP FastCGI Examples](https://www.nginx.com/resources/wiki/start/topics/examples/phpfcgi/)
- [Why Use fastcgi_pass 127.0.0.1:9000?](https://serverfault.com/questions/1094793/what-is-this-nginx-location-for-php-fpm-fastcgi-pass-127-0-0-19000-really-doing)
- [Install Nginx with PHP-FPM Video](https://www.youtube.com/watch?v=I_9-xWmkh28&ab_channel=ProgramWithGio)
- [FastCGI Explanations and Commands](https://www.digitalocean.com/community/tutorials/understanding-and-implementing-fastcgi-proxying-in-nginx)

PHP-FPM (FastCGI Process Manager) runs as an isolated service when you use PHP-FPM.
	Employing this PHP version as the language interpreter means requests will be processed via a TCP/IP socket, and the Nginx server handles HTTP requests only, while PHP-FPM interprets the PHP code. Utilizing two separate services is essential for efficiency.
	It integrates well with WordPress.

# Docker Compose
- [Docker Compose Tutorial](https://openclassrooms.com/fr/courses/2035766-optimisez-votre-deploiement-en-creant-des-conteneurs-avec-docker/6211624-decouvrez-et-installez-docker-compose)

## Docker Compose Commands
```bash
- docker-compose up -d --build # Creates and builds all containers and runs them in the background.
- docker-compose ps # Checks the status of all containers.
- docker-compose logs -f --tail 5 # Displays the last 5 lines of logs for your containers.
- docker-compose stop # Stops all containers in the stack.
- docker-compose down # Destroys all your resources.
- docker-compose config # Checks the syntax of your docker-compose file.
```

## Inside the Docker Compose File
All the information about what each line means is in this [tutorial](https://openclassrooms.com/fr/courses/2035766-optimisez-votre-deploiement-en-creant-des-conteneurs-avec-docker/6211677-creez-un-fichier-docker-compose-pour-orchestrer-vos-conteneurs).

# WORDPRESS 
## Useful Links
- [What is the WordPress CLI?](https://www.dreamhost.com/wordpress/guide-to-wp-cli/#:~:text=The%20WP%2DCLI%20is%20a,faster%20using%20the%20WP%2DCLI.)  
- [Learn More About wp-config.php](https://wpformation.com/wp-config-php-et-functions-php-fichiers-wordpress/)  
- [php-fpm - www.conf](https://myjeeva.com/php-fpm-configuration-101.html)  

*Definitions*:
*wp-config.php*: This file tells your database how to get your files and how to process them.

## Steps to Create Your WordPress
1. **Create Your Dockerfile Image**
	- Download PHP-FPM.
	- Copy the `www.conf` file into `php/7.3/fpm/pool.d/`.
	- Create the PHP directory to enable PHP-FPM to run.
	- Copy the script and launch it.
	- Go to the HTML directory.
	- Launch PHP-FPM.

2. **Create a Script**
	- Download WordPress.
	- Create the configuration file for WordPress.
	- Move the WordPress files into the HTML directory.
	- Provide the 4 environment variables for WordPress.

3. **Create a www.conf File**
You need to edit `www.conf` and place it in `/etc/php/7.3/fpm/pool.d` and `wp-config.php` to disable access to the WordPress installation page when you access your site at `https://<yourlogin>.42.fr`.
	- Set `listen = 0.0.0.0:9000` to listen on all ports.
	- Increase the `pm` values to avoid a 502 error page.

# MARIADB
MariaDB will be the database to store information about your WordPress users and settings. In this section, we will create the MariaDB image and set up 2 users.

## Useful Links
- [Import-Export Databases](https://www.interserver.net/tips/kb/import-export-databases-mysql-command-line/)  
- [Create and Grant Permissions to a User](https://www.daniloaz.com/en/how-to-create-a-user-in-mysql-mariadb-and-grant-permissions-on-a-specific-database/)  
- [Why Create the /var/run/mysqld Directory](http://cactogeek.free.fr/autres/DocumentationLinux-Windows/LinuxUbuntu/ProblemeMYSQL-mysqld.sockInexistant.pdf)  
- [How to Grant All Privileges to a User on a Database](https://chartio.com/resources/tutorials/how-to-grant-all-privileges-on-a-database-in-mysql/)  
- [How to Import a Database](https://www.journaldunet.fr/web-tech/developpement/1202663-comment-importer-un-fichier-sql-dans-mysql-en-ligne-de-commande/)  

## MariaDB Useful Commands
```bash
mysql -uroot # Connect to MySQL CLI.
SELECT User FROM mysql.user; # View all users.
USE wordpress; # Connect to your WordPress database.
mysqldump -u username -p databasename > filename.sql # Export the database to a file.
mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql # Import the database from a file.
```

## Steps to Create Your Own MariaDB Image
1. **Create a Dockerfile**
	- Download `mariadb-server` and `mariadb-client`.
	- To run MariaDB on your container, copy your `.sh` script and `.sql` file to `/usr/local/bin/`.
	- Set the correct permissions to execute `mysqld` (the MySQL daemon).
	- Launch your script to install MariaDB.
	- Then, use `CMD` to allow the database to listen on all IPv4 addresses.

2. **Create a Script (.sh File)**
	- `mysql_install_db` initializes the MySQL data directory and creates the system tables if they do not exist.
	- In this script, we downloaded MariaDB on the container, installed it, and created the root user.
	- Then, we used the `GRANT` function from MySQL CLI to give all privileges to the root user.

3. **Create Your File.sql**
	- 2 options:
		1. Create the database, the user, and grant all privileges to the user, as [malatini did](https://github.com/42cursus/inception/blob/validated/srcs/requirements/mariadb/config/create_db.sql).
		2. Export your own `wordpress.sql` as I did (and Lea did!).
			- Step 1: Create your admin user on WordPress:
				You might not know what this is, no problem! It means you will export your admin user from your database and include it in your `.sql` file.
				- Go to your WordPress website (`https://localhost:443`) and create your user using the same username and password as in your `.env` file.
			- Step 2: Export your admin user.sql:
				You need to access your MariaDB container and run the following command:
				- `mysqldump -u 'username' -p 'databasename' > filename.sql` (replace `username` and `databasename` with the values in your `.env` file).
				- You'll now have a file called `filename.sql` in your current directory.
				- Use `cat filename.sql` in your container and copy-paste the output into your project’s `.sql` file.
				- Your `.sql` file is now ready to be imported.
			- Step 3: Relaunch your docker-compose:
				- TADA! You will be directly on your website, bypassing the installation phase.

### Commands to Check if Everything is Working
```bash
SHOW DATABASES; # Show all databases.
USE wordpress; # Access the WordPress database.
SHOW TABLES; # Show all tables in the selected database.
SELECT wp_users.display_name FROM wp_users; # Display the username from the WordPress database.
SELECT * FROM wp_users; # Select all records from the wp_users table.
```

# Report
If you find any errors in this README or if you want to add more information, please create an issue in the project. I will be happy to help and improve the project.