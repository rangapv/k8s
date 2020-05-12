#This is the install script for Kubernetes Nodes
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

        sudo iptables -P FORWARD ACCEPT

	sudo systemctl enable kubelet
        sudo apt-get install -y cowsay
        echo -e "ONE MORE THING ........ \n Copy the config file from the Master/ADM node and store\n it to the \$HOME/.kube/config \n When the config file is in place make sure you have set the right permissions on it \n mkdir -p \$HOME/.kube \n sudo cp -i /etc/kubernetes/admin.conf \$HOME/.kube/config \n sudo chown \$(id -u):\$(id -g) \$HOME/.kube/config \n\n" | cowsay -W95 -f default
        echo "PRESS ENTER TO CONTINUE\n"
	read enter
#	echo -e "Press Enter after you have done the above steps \n" cowsay -W95 -f default
	echo -e "Assuming that you have the config file in the right place as mentioned above \n Enter the following commnad to start the kubelet \n sudo kubelet --kubeconfig \$HOME/.kube/config --cluster-dns 10.96.0.10 & \n\n " | cowsay -W95 -f default
       
	fi 
else
   echo "Pls install docker and re-run this Script"
fi


# end of $ui if
