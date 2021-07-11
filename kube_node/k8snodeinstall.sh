#!/bin/bash
set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh)
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/checkruntime.sh)
kubecount=0

kubeblock() {

 add2="$@"
 sudo $cm1 update && sudo $cm1 install -y apt-transport-https ca-certificates
 sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
 echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null
 sudo $cm1 update
 sudo $cm1 install -y kubectl kubeadm kubelet
 sudo apt-mark hold kubectl kubeadm kubelet
 sudo modprobe br_netfilter
 echo "br_netfilter" | sudo tee /etc/modules-load.d/k8s.conf > /dev/null
 echo -e "net.bridge.bridge-nf-call-ip6tables = 1 \nnet.bridge.bridge-nf-call-iptables = 1" | sudo tee /etc/sysctl.d/k8s.conf > /dev/null
 echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null
 sudo sysctl --system
 sudo $cm1 install -y cowsay

}


kubecomsts() {
kubecount=0 
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


kubejoin() {
echo ""
}

kcom=( kubectl kubeadm kubelet)
kubecomsts "${kcom[@]}"


if [[ -z "$mac" ]]
then

	if [[ (( $Flag -eq 1 )) && (( $kubecount -lt 3 )) ]]
        then
         if [ ! -z "$d1" ]
         then
         sudo echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null
	 kubeblock
         elif [ ! -z "$u1" ]
         then
         sudo echo "1" | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null
         kubeblock
         fi
        fi
        if [[  $Flag -eq 1 && $kubecount -eq 3 ]]
        then
	 if [ ! -z "$d1" ]
	 then
	 kubejoin
         elif [ ! -z "$u1" ]
	 then
	 kubejoin
         fi
        fi

kubecomsts "${kcom[@]}"

       if [[ $Flag -eq 0 ]]
       then
       echo "Pls install containerd/docker and re-run this Script"
       elif [[ $kubecount -lt 3 ]]
       then
       echo "All of k8s components are not present"
       else
	echo "The total k8s components that are installed is $kubecount "
       fi
fi
