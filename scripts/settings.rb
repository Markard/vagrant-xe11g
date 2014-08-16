class Homestead
  def Homestead.configure(config, settings)
    # Configure The Box
    config.vm.box = "centos-6.4-x86_64"
    config.vm.box_url = "https://dl.dropboxusercontent.com/u/97268835/boxes/centos-6.4-x86_64.box"
    config.vm.hostname = "development.xe11"

    # Configure Port Forwarding To The Box
    config.vm.network "forwarded_port", guest: 80, host: 8000
    config.vm.network "forwarded_port", guest: 1521, host: 1521

    # Configure A Private Network IP
    config.vm.network :private_network, ip: settings["ip"] ||= "192.168.10.10"

    # Configure A Few VirtualBox Settings
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
      vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

    # Register All Of The Configured Shared Folders
    settings["folders"].each do |folder|
      config.vm.synced_folder folder["map"], folder["to"],
      mount_options: ["dmode=777", "fmode=666"], type: folder["type"] ||= nil, 
        group: folder["group"] ||= nil, owner: folder["owner"] ||= nil
    end

    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path = "puppet/modules"
      puppet.manifest_file  = "site_xe11g.pp"
      puppet.options = "--verbose"
    end

    config.vm.provision :shell, :path => "scripts/provision/install_provision.sh"

    # Install All The Configured Apache
    settings["sites"].each do |site|
      config.vm.provision "shell" do |s|
          s.inline = "bash /vagrant/scripts/serve.sh $1 $2"
          s.args = [site["map"], site["to"]]
      end
    end
  end
end
