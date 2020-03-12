#!/usr/bin/env bash
echo -e "\n###===> Bootstrap script\n"
sudo sed -i -e "\\#PasswordAuthentication yes# s#PasswordAuthentication yes#PasswordAuthentication no#g" /etc/ssh/sshd_config
sudo systemctl restart sshd.service
