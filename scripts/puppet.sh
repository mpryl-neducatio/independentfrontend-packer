#!/bin/bash -eux

# Prepare puppetlabs repo
wget http://apt.puppetlabs.com/puppetlabs-release-saucy.deb
dpkg -i puppetlabs-release-saucy.deb
apt-get -y update

# Install puppet/facter
apt-get install -y ruby puppet
# Puppet modules
if ! `puppet module list | grep -q puppetlabs-postgresql`  ; then
    puppet module install puppetlabs-postgresql -v 3.3.3
fi
if ! `puppet module list | grep -q puppetlabs-nodejs`  ; then
    puppet module install puppetlabs-nodejs -v 0.6.1
fi
# puppet module install willdurand/nodejs
if ! `puppet module list | grep -q puppetlabs-apt`  ; then
    puppet module install puppetlabs-apt
fi
# Remove deb package
rm -f puppetlabs-release-saucy.deb