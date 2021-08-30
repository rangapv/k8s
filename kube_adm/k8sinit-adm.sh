#!/bin/bash
set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh)
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/checkruntime.sh)
kubecount=0

kubeblock() {

 add2="$@"
 sudo $cm1 update && sudo $cm1 install -y apt-transport-https ca-certificates
 sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
 echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
 sudo $cm1 update
 sudo $cm1 install -y kubectl kubeadm kubelet
 sudo apt-mark hold kubectl kubeadm kubelet
 sudo modprobe br_netfilter
 echo "br_netfilter" | sudo tee /etc/modules-load.d/k8s.conf
 echo -e "net.bridge.bridge-nf-call-ip6tables = 1 \nnet.bridge.bridge-nf-call-iptables = 1" | sudo tee /etc/sysctl.d/k8s.conf
 echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward
 sudo sysctl --system
 sudo $cm1 install -y cowsay

}


kubeblockd() {

 add2="$@"
 sudo $cm1 update && sudo $cm1 install -y apt-transport-https ca-certificates
 sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
 echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
 sudo $cm1 update
 sudo $cm1 install -y kubectl kubeadm kubelet
 sudo systemctl enable kubelet 
 sudo systemctl start kubelet
 sudo $cm1 install -y cowsay

}

kubeinit() {

	init1=$( sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --token-ttl 0 | sudo tee ./flag.txt)
	init2=$( mkdir -p $HOME/.kube)
	init3=$( sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config)
	init2=$( sudo chown $(id -u):$(id -g) $HOME/.kube/config)
        echo "Check the flag.txt for tokens to join the master"
}


kubecomsts() {
 
arrkc=("$@")
for n in "${arrkc[@]}"
do
	jj=`which $n`
	js="$?"
	if [[ $js -ne 0 ]]
	then
		echo "The k8s component $n is not installed pls do so"
        else
		((kubecount+=1))
	fi
done

}

kcom=( kubectl kubeadm kubelet)
kubecomsts "${kcom[@]}"


if [[ -z "$mac" ]]
then

	if [[  (( $Flag -eq 1 )) &&  ( ! -f flag.txt )  ]]
        then
           if [[ ! -z "$d1" ]]
	   then
	         if [[ (( $crun -eq 1 )) ]] 
	         then
                 kubeblock
	         elif [[ (( $drun -eq 1 )) ]]
	         then
                 kubeblockd
                 fi
	   kubeinit
           elif [[ ! -z "$u1" ]]
           then
		 if [[ (( $crun -eq 1 )) ]]
                 then
                 kubeblock
	         elif [[ (( $drun -eq 1 )) ]]
                 then
                 kubeblockd
                 fi
           kubeinit
           fi
       elif [[ (( $Flag -eq 0 )) ]]
       then
          echo "Pls install containerd/docker and re-run this Script"
       else [[ (( $kubecount -lt 3 )) ]]
	     echo "All of k8s componenets are not present"
	     echo "Cannot run init script pls debug"
       fi
fi
