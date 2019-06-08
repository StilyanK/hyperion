# Application Setup

### Config Settings
#### Create the file
```
config/config.yaml
```
#### with the following content
```
devmode: true
app:
  centryl:
    address: 127.0.0.1
    port: 9000
  api:
    address: 127.0.0.1
    port: 9002
  front:
    address: 127.0.0.1
    port: 9003

db:
  host: localhost
  port: 5432
  user: user
  password: 'user'
  database: centryl_demo
```

### Create database and role (user)
#### From the psql console as superuser (postgres):
```
CREATE ROLE "user" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN ENCRYPTED PASSWORD 'password';
CREATE DATABASE "centryl_demo" WITH OWNER="user" encoding='UTF-8' lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0;
REVOKE ALL ON DATABASE "hyperion" FROM public;
GRANT ALL ON SCHEMA public TO "stilyan" WITH GRANT OPTION;
\connect "hyperion";
ALTER SCHEMA public OWNER TO "stilyan";
```
#### Install DB
```
pub run cl_install:install -r
```

### Nginx Setup
#### SSL Support - create and execute the following:
```
#!/bin/sh
#nginx ssl [https://www.digitalocean.com/community/tutorials/how-to-create-a-ssl-certificate-on-nginx-for-ubuntu-12-04]

nginx=/etc/nginx
mkdir $nginx/ssl
cd $nginx/ssl
openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```
#### Generate nginx file
```
pub run cl_install:gen_nginx > config/centryl-nginx
```
#### Create link to the generated file
```
cd /etc/nginx/sites-enabled
ln -s [project_path]/config/centryl-nginx ./
```
#### Reload Nginx
```
/etc/init.d/nginx reload
```

### Running the application

#### Run the server
```
dart bin/app.dart
```
#### Run webdev
```
pub run webdev serve
```

#### Access the Application
```
https://localhost/centryl
```

# Configuring Webstorm to run the project
#### Create file nginx.c
```
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
   setuid( 0 );
   clearenv();
   const char* part1    = "rm /etc/nginx/sites-enabled/centryl-nginx;";
   const char* part2    = "ln -s $PWD/config/centryl-nginx /etc/nginx/sites-enabled/centryl-nginx;";
   const char* part3    = "/usr/sbin/nginx -s reload;";
   char* str0           = malloc(strlen(part1) + strlen(part2) + strlen(part3) + 1);
   strcpy(str0,part1);
   strcat(str0,part2);
   strcat(str0,part3);
   system(str0);
   return 0;
}
```
#### Compile nginx.c
```
gcc nginx.c -o nginx
```
#### Set the permissions
```
chown root.root nginx
chmod +s nginx
```
#### Create nginx external tool
##### Settings > Tools > External Tools > '+'
```
name: nginx_autoreload
```
##### Tool Settings section
```
Program: /path_to/nginx
Working directory: $ProjectFileDir$
```
* Note $ProjectFileDir$ is an Webstorm variable and should be written as is

#### Create the configuration
##### Edit configurations > Add new configuration > Dart Command Line App
```
Dart file: /project_path/bin/app
Working directory: /project_path
```
##### Before launch > '+' > Run External tool and choose the tool