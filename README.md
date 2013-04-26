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

Usage:

```
$ git clone https://github.com/bdwilliams/vagrant-base-lamp.git project
```

	You will then need to "cd project/www" and place any code directories that will be configured as vhosts.
	
	Alternatively, you may place any *.sql files into the project/sql directory and have them loaded during vagrant up.

```
$ git submodule init
$ git submodule update
```

	cp sites.cfg.dist sites.cfg and edit appropriately.

Finally

	./setup.sh

The setup command will:
- Generate the Vagrantfile adding vhosts.
- Prep any *.sql files located in the sql/ directory for auto-loading.
- vagrant up

After setup completes, you should be able to access any of your configured virtual hosts on port 8080.  Example:  http://www.yourhost.dev:8080

Note:
Mac OSX users may use the following command to port forward 80 -> 8080

	sudo ipfw add 100 fwd 127.0.0.1,8080 tcp from any to any 80 in