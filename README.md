Documentation
=============

This repository contains a general vagrant configuration for developing web applications using a LAMP stack.

The package installs the following:
- ubuntu
- apache2 
- php 5.3 with xdebug
- mysql
- apt
- imagemagick
- git
- phpmyadmin
- webgrind

Configuration
=============

This repository requires the following pre-requisites: [Vagrant](http://vagrantup.com/) and [VirtualBox](htp://www.virtualbox.org).

Installation
============

```
$ git clone https://github.com/bdwilliams/vagrant-base-lamp.git project
$ cd project
$ git submodule init
$ git submodule update
```

### Virtual Host Docroot Configuration

You will then need to place any code that will be configured as vhosts in the www/ directory. (Example: www/yourhost/).
	
### SQL Configuration

You may place any *.sql files into the project/sql directory and have them loaded during vagrant up.

### Configure Vhosts

	cp sites.cfg.dist sites.cfg
	
Edit the sites.cfg file to reflect the host you will be accessing via your browser and the directory located in the www/ directory. (Example: www.yourhost.dev:yourhost)

### Finally

	./setup.sh

The setup command will:
- Generate the Vagrantfile adding vhosts.
- Prep any *.sql files located in the sql/ directory for auto-loading.
- vagrant up

### Additional Notes

- After setup completes, you should be able to access any of your configured virtual hosts on port 8080.  Example:  http://www.yourhost.dev:8080
- phpMyAdmin is accessible from any vhost via http://www.yourhost.dev:8080/phpmyadmin
- All vhost logs are written to the logs/ directory so there is no need to ssh into the vagrant server.

### Optional Note

Mac OSX users may use the following command to port forward 80 -> 8080

	sudo ipfw add 100 fwd 127.0.0.1,8080 tcp from any to any 80 in
