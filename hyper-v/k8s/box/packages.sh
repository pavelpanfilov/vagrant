#!/usr/bin/env bash
#utils
echo -e "\n###===> PACKAGES: utils\n"
sudo yum install -y nano htop tmux git
#docker
echo -e "\n###===> PACKAGES: docker\n"
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
sudo yum-config-manager -y \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
#kube
echo -e "\n###===> PACKAGES: k8s\n"
sudo bash -c 'cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF'
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
sudo bash -c 'cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF'
sysctl --system
sudo yum install -y kubelet kubeadm kubectl kubernetes-cni --disableexcludes=kubernetes
systemctl enable kubelet
#golang
echo -e "\n###===> PACKAGES: crictl\n"
sudo rpm --import https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO
curl -s https://mirror.go-repo.io/centos/go-repo.repo | sudo tee /etc/yum.repos.d/go-repo.repo
sudo yum install -y golang
go get github.com/kubernetes-incubator/cri-tools/cmd/crictl
sudo ln -s /home/vagrant/go/bin/crictl /usr/local/bin/crictl
sudo swapoff -a
sudo sed -i 's#/swapfile none swap defaults 0 0##g' /etc/fstab
#cleanup
sudo yum clean all
cat /dev/null > ~/.bash_history && history -c && exit