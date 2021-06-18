#!/usr/bin/bash
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh)


kubeblock() {

 add2="$@"
 sudo $cm1 update && sudo $cm1 install -y apt-transport-https ca-certificates
 sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo $add2 add -

 if [ -f "/etc/apt/sources.list.d/kubernetes.list" ]
 then
	 echo "kuberneteslist found\n"
	 sudo truncate -s 0 /etc/apt/sources.list.d/kubernetes.list
 else
	 echo "creating kubernetes list\n"
	 sudo touch /etc/apt/sources.list.d/kubernetes.list
 fi

 sudo chmod 777 /etc/apt/sources.list.d/kubernetes.list
 sudo curl -fsSLO /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
 sudo echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list
 sudo $cm1 update
 sudo $cm1 install -y kubectl kubeadm kubelet
 sudo apt-mark hold kubelet kubeadm kubelet
# sudo systemctl enable kubelet && sudo systemctl start kubelet

 sudo $cm1 install -y cowsay


}

dk=$(which containerd)
ds=$?
if [[ -z "$mac" ]]
then

if [[  $ds = 0  ]]
then

	if [ ! -z "$d1" ]
	then 
        kubeblock apt-key
        echo -e "ONE MORE THING ........ \n execute the below command and capture the node tokens\n sudo kubeadm init  --config=./kube-adm-containerd.yaml --pod-network-cidr=10.244.0.0/16 --token-ttl 0 \n\n" | cowsay -W95 -f default
       
	fi 
else
   echo "Pls install containerd and re-run this Script"
fi
fi

# end of $ui if
