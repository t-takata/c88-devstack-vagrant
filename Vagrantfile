# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "8096", "--cpus", "4", "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 6080, host: 16080
  
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get install -y git git-review
    sudo -i -u vagrant sh /vagrant/do-stack.sh
  SHELL
end
