#! /bin/bash
li=$(uname -s)
li2="${li,,}"

echo $li2

u1=$(cat /etc/*-release | grep ubuntu)

if [ ! -z "$u1" ]
then 
echo "hi"

sudo apt-get update && sudo apt-get install -y apt-transport-https

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -



if [ -f "/etc/apt/sources.list.d/kubernetes.list" ]
then
		echo "kubernetes.list found\n"
		sudo truncate -s 0 /etc/apt/sources.list.d/kubernetes.list 
else
		echo "Creating kubernetes list"
		sudo touch /etc/apt/sources.list.d/kubernetes.list 
fi

sudo chmod 777 /etc/apt/sources.list.d/kubernetes.list 
sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni



fi 
# end of $ui if
