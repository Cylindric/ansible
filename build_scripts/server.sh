#!/bin/sh
yum update -y

ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""

cat /vagrant/artifacts/ansible_rsa.pub >> /root/.ssh/authorized_keys
