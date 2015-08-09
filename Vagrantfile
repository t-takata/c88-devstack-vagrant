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
    cat > /tmp/local.conf <<'EOS'
[[local|localrc]]
RECLONE=True

LIBS_FROM_GIT=python-neutronclient,python-novaclient,python-glanceclient

KEYSTONE_TOKEN_FORMAT=UUID
PRIVATE_NETWORK_NAME=net1
PUBLIC_NETWORK_NAME=ext_net

disable_service n-net
enable_service neutron q-svc q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta

Q_PLUGIN=ml2

#-----------------------------
# Devstack configurations
#-----------------------------
LOGDIR=$DEST/logs
SCREEN_LOGDIR=$LOGDIR
SCREEN_HARDSTATUS="%{= rw} %H %{= wk} %L=%-w%{= bw}%30L> %n%f %t*%{= wk}%+Lw%-17< %-=%{= gk} %y/%m    /%d %c"
LOGFILE=$LOGDIR/devstack.log
LOGDAYS=1

ADMIN_PASSWORD=pass
MYSQL_PASSWORD=stackdb
RABBIT_PASSWORD=stackqueue
SERVICE_PASSWORD=$ADMIN_PASSWORD
SERVICE_TOKEN=xyzpdqlazydog

[[post-config|$NEUTRON_CONF]]
[quotas]
quota_network = -1
quota_subnet = -1
quota_port = -1
quota_router = -1
quota_floatingip = -1
quota_security_group = -1
quota_security_group_rule = -1
EOS
    cat > /tmp/do-stack.sh <<EOS
cd
git clone https://github.com/openstack-dev/devstack.git
cd devstack
cp /tmp/local.conf ./
./stack.sh
EOS
    sudo -i -u vagrant sh /tmp/do-stack.sh
  SHELL
end
