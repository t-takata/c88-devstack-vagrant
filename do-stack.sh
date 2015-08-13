#!/bin/sh

cd
git clone https://github.com/openstack-dev/devstack.git
cd devstack
cp /vagrant/local.conf ./
./stack.sh
