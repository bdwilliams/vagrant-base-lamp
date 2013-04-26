#!/bin/bash

# Chef for the proper config
if [ ! -f ./sites.cfg ]
then
	echo "You didn't copy your sites.cfg.dist to sites.cfg.";
	exit 0;
fi

vagrant destroy

HOSTSFILE="";
CONFIG="";

# Read config
for i in `cat ./sites.cfg | grep -v '#'`:
do
	URL=`echo $i | cut -d \: -f 1`
	DIR=`echo $i | cut -d \: -f 2`

	HOSTSFILE+="$URL "
	CONFIG+="      {
                        name: \"$URL\",
                        docroot: \"/vagrant/www/$DIR\",
                        server_name: \"$URL\",
                        server_aliases: [\"$URL\"],
                    },"
done

if [ ! -f /etc/hosts.orig ]
then
	sudo cp /etc/hosts /etc/hosts.orig
fi

sudo cat > hosts << EOF
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost
fe80::1%lo0	localhost

127.0.0.1	$HOSTSFILE
EOF

sudo mv hosts /etc/hosts

sudo cat > Vagrantfile << EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    # All Vagrant configuration is done here. The most common configuration
    # options are documented and commented below. For a complete reference,
    # please see the online documentation at vagrantup.com.
    config.vm.share_folder("vagrant-root", "/vagrant", ".", :owner => "www-data", :group => "www-data")
    
    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "lucid64"

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

    config.vm.define :project do |project_config|
        project_config.vm.forward_port 80, 8080
      
        project_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path = ["chef/cookbooks/", "chef/site-cookbooks/"]
	    
            chef.run_list = ["recipe[site]"]
            chef.json = {
                sites:[
                    $CONFIG
                ],
                sql:[
                	$DB
                ],
                apache:{
                    default_site_enabled: false,
                    default_modules:[
                        "status","alias","auth_basic","authn_file","authz_default","authz_groupfile","authz_host","authz_user","autoindex","dir", "env", "mime", "negotiation", "setenvif",
                        "rewrite", "php5", "headers", "include"]
                },
                mysql:{
                    server_root_password: 'root'
                }
            }
        end
    end
end
EOF

files=$(ls sql/*.sql | grep -v all_files.sql 2> /dev/null | wc -l)

if [ $files != "0" ]
then
	cat sql/*.sql > sql/all_files.sql
fi

vagrant up

if [ -f sql/all_files.sql ]
then
	rm sql/all_files.sql
fi
