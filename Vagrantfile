# -*- mode: ruby -*-
# vi: set ft=ruby :

SALT_VERSION=ENV.fetch('SALT_VERSION') { '3000' }

SHELL_SCRIPT = <<SCRIPT
OSCODENAME=$(lsb_release -cs)
DISTRO=$(lsb_release -is);
DISTRO=${DISTRO,,}
VARIANT=$(lsb_release -rs)
apt-get install apt-transport-https
APT_URL="https://repo.saltstack.com/py3/${DISTRO}/${VARIANT}/amd64/#{SALT_VERSION}"
mkdir -p /etc/salt/pki

cp /vagrant/salt/{minion,master,roster} /etc/salt/.
chown root: -R /etc/salt/pki

apt-key adv --fetch-keys ${APT_URL}/SALTSTACK-GPG-KEY.pub
echo "deb ${APT_URL} ${OSCODENAME} main" > /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get -o Dpkg::Options::="--force-confold" -y install salt-minion salt-master salt-ssh

# patch salt
if [ -f /vagrant/patches/#{SALT_VERSION}/salt-master-patch.sh ]; then
  echo "Patching salt-master v#{SALT_VERSION}"
  bash /vagrant/patches/#{SALT_VERSION}/salt-master-patch.sh
  systemctl restart salt-master
fi

mkdir -p /etc/salt/pki/master/ssh/
echo '' | ssh-keygen -f /etc/salt/pki/master/ssh/salt-ssh.rsa -t rsa
mkdir -p /root/.ssh/
cat /etc/salt/pki/master/ssh/salt-ssh.rsa.pub >> /root/.ssh/authorized_keys

# deploy ssh config to make it easier to salt-ssh to localhost
tee /root/.ssh/config<<SSH_CONF
Host localhost
	StrictHostkeyChecking no
	UserKnownHostsFile=/dev/null
SSH_CONF

SCRIPT

Vagrant.configure("2") do |config|

  # UBUNTU
  ## trusty
  config.vm.define "trusty", autostart: false do |distro|
    distro.vm.box = "ubuntu/trusty64"
    distro.vm.box_url = "https://app.vagrantup.com/ubuntu/boxes/trusty64"
  end

  ## xenial
  config.vm.define "xenial", autostart: false do |distro|
    distro.vm.box = "ubuntu/xenial64"
    distro.vm.box_url = "https://app.vagrantup.com/ubuntu/boxes/xenail64"
  end

  ## bionic
  config.vm.define "bionic", autostart: false do |distro|
    distro.vm.box = "ubuntu/bionic64"
    distro.vm.box_url = "https://app.vagrantup.com/ubuntu/boxes/bionic64"
  end
  # END UBUNTU

  # DEBIAN
  ## stretch
  config.vm.define "jessie", autostart: false do |distro|
    distro.vm.box = "debian/contrib-jessie64"
    distro.vm.box_url = "https://app.vagrantup.com/debian/boxes/contrib-jessie64"
  end

  ## stretch
  config.vm.define "stretch", autostart: false do |distro|
    distro.vm.box = "debian/contrib-stretch64"
    distro.vm.box_url = "https://app.vagrantup.com/debian/boxes/contrib-stretch64"
  end

  ## buster
  config.vm.define "buster", autostart: false do |distro|
    distro.vm.box = "debian/contrib-buster64"
    distro.vm.box_url = "https://app.vagrantup.com/debian/boxes/contrib-buster64"
  end
  # END DEBIAN

  config.vm.synced_folder "salt", "/srv/salt"

  config.vm.provision "shell",
    run: "once",
    inline: SHELL_SCRIPT

end
