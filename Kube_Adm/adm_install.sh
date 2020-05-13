#! /bin/bash
li=$(uname -s)
li2="${li,,}"

echo $li2

u1=$(cat /etc/*-release | grep ubuntu)

dk=$(docker --version)
ds=$?
if [[ $ds == 0 ]]
then

	if [ ! -z "$u1" ]
	then 

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
		sudo echo "deb http://apt.kubernetes.io/ kubernetes-$(lsb_release -cs) main" >> /etc/apt/sources.list.d/kubernetes.list

	sudo apt-get update

	sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

	sudo systemctl enable kubelet && sudo systemctl start kubelet
        sudo apt-get install -y cowsay
        echo -e "ONE MORE THING ........ \n execute the below command and capture the node tokens\n sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --token-ttl 0 \n\n" | cowsay -W95 -f default
       
	fi 
else
   echo "Pls install docker and re-run this Script"
fi


# end of $ui if
