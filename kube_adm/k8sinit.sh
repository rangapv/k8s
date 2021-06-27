#!/bin/bash
set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh)
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/checkruntime.sh)

kubegist() {

   if [[ -f "adm-init.yaml" ]]
   then	   
	sudo chmod 777 adm-init.yaml
        cat /dev/null > adm-init.yaml 
   fi
	wg=`sudo wget https://gist.githubusercontent.com/rangapv/3fd8a52f66bd412b1cc0663a45c74f68/raw/319296547705503a675d5b10121d59df67de3aff/kube-adm-containerd.yaml `
        sudo cp ./kube-adm-containerd.yaml ./kube-adm-old.yaml
      	convert=$( kubeadm config migrate --old-config kube-adm-old.yaml --new-config adm-init.yaml)
  rc= echo "$?"
  if [[ ( $rc -eq 0 ) ]]
  then
  echo "---" | sudo tee -a adm-init.yaml > /dev/null
  echo "kind: KubeletConfiguration" | sudo tee -a adm-init.yaml > /dev/null
  echo "apiVersion: kubelet.config.k8s.io/v1beta1" | sudo tee -a adm-init.yaml > /dev/null
  echo "cgroupDriver: systemd" | sudo tee -a adm-init.yaml > /dev/null
  fi

}
kubeinit() {

	init1=$( sudo kubeadm init --config=./adm-init.yaml | sudo tee ./flag.txt)
	init2=$( mkdir -p $HOME/.kube)
	init3=$( sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config)
	init2=$( sudo chown $(id -u):$(id -g) $HOME/.kube/config)
        echo "Check the flag.txt for tokens to join the master"
}

kuberun() {
arrayk=("$@")

for k in ${arrayk[@]}
do
dk=$(which $k | echo $?)
dks=$(sudo systemctl status $k | echo $?u)
dock[$dk]=$dks
done
}
runc1=( containerd docker)
kuberun "${runc1[@]}" 

if [[ -z "$mac" ]]
then

if [[  $Flag -eq 1  ]]
then

	if [ ! -z "$d1" ]
	then
	kubegist
	kubeinit
        elif [ ! -z "$u1" ]
	then
	kubegist
	kubeinit
        fi
else
   echo "Pls install containerd/docker and re-run this Script"
fi
fi

