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
                          {
                        name: "www.churchbug.site",
                        docroot: "/vagrant/www/churchbug-web",
                        server_name: "www.churchbug.site",
                        server_aliases: ["www.churchbug.site"],
                    },      {
                        name: "dashboard.churchbug.site",
                        docroot: "/vagrant/www/dashboard.churchbug.com",
                        server_name: "dashboard.churchbug.site",
                        server_aliases: ["dashboard.churchbug.site"],
                    },      {
                        name: "www.kxmx.site",
                        docroot: "/vagrant/www/kxmx-radio",
                        server_name: "www.kxmx.site",
                        server_aliases: ["www.kxmx.site"],
                    },
                ],
                sql:[
                	
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
