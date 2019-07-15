#!/bin/sh

yum update -y
yum install -y vim ansible

ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""

if [ ! -d /vagrant/artifacts ]; then
    mkdir /vagrant/artifacts
fi

if [ -f /vagrant/artifacts/ansible_rsa.pub ]; then
    rm -f /vagrant/artifacts/ansible_rsa.pub
fi

cp ~/.ssh/id_rsa.pub /vagrant/artifacts/ansible_rsa.pub
cat /vagrant/artifacts/ansible_rsa.pub >> /root/.ssh/authorized_keys
