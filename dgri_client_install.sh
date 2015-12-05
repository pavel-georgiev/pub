#!/bin/bash

set +e

# Install EPEL repository
sudo yum -y install epel-release >/dev/null

# Install ansible
sudo yum -y install ansible >/dev/null

# Install DGRI yum repository
sudo rpm -Uvh https://s3.amazonaws.com/dgri-rpm-repo/x86_64/dgri-rpm-repo-1-0.1.noarch.rpm >/dev/null

# Install DGRI client software
sudo yum install -y ansible-dgri-modules dgri-query >/dev/null

# Create a sample ansible group (only localhost) that we will collect data from
echo -e '\n[my-ansible-group]\nlocalhost\n' |sudo tee -a /etc/ansible/hosts > /dev/null

# Done, print configuration instructions
cat << EOF


INSTALL COMPLETE


To configure your systems:

1) Set your username and password in /etc/ansible-dgri-modules.conf

2) (Optional) Add more hosts to the ansible group [my-ansible-group] in
   /etc/ansible/hosts. Remove localhost if not needed

3) Make sure ansible (running as root) can ssh to the hosts in
   group [my-ansible-group]. To verify:
# sudo ansible -m ping my-ansible-group

To collect data from servers (will be done by a cronjob):
# sudo ansible-playbook /usr/share/dgri/ansible-playbooks/dgri.yml

To use the CLI for querying systems:
# dgri-query --help

Enjoy!
EOF


