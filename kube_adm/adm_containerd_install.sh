#!/usr/bin/bash
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh)


dk=$(which containerd)
ds=$?
if [[ -z "$mac" ]]
then

if [[  $ds = 0  ]]
then

	if [ ! -z "$d1" ]
	then 

        sudo $cm1 install -y cowsay
        echo -e "ONE MORE THING ........ \n execute the below command and capture the node tokens\n sudo kubeadm init  --config=./kube-adm-containerd.yaml --pod-network-cidr=10.244.0.0/16 --token-ttl 0 \n\n" | cowsay -W95 -f default
       
	fi 
else
   echo "Pls install containerd and re-run this Script"
fi
fi

# end of $ui if
