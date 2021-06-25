#!/usr/bin/bash
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh)


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

kubeinit() {

	echo -e "ONE MORE THING ........ \n execute the below command and capture the node tokens\n sudo kubeadm init --config=`./adm-init.yaml` \n\n" | cowsay -W145 -f default
	echo -e "Finally after the above command run this \n mkdir -p \$HOME/.kube
\n sudo cp -i /etc/kubernetes/admin.conf \$HOME/.kube/config
\n sudo chown \$(id -u):\$(id -g) \$HOME/.kube/config" | cowsay -W120 -f default

}

kubegist() {

  wg=`wget https://gist.githubusercontent.com/rangapv/3fd8a52f66bd412b1cc0663a45c74f68/raw/319296547705503a675d5b10121d59df67de3aff/kube-adm-containerd.yaml`
  convert=$( kubeadm config migrate --old-config kube-adm-containerd.yaml --new-config adm-init.yaml)
  rc= echo "$?"
  if [[ ( $rc -eq 0 ) ]]
  then
  echo "---" | sudo tee -a adm-init.yaml > /dev/null
  echo "kind: KubeletConfiguration" | sudo tee -a adm-init.yaml > /dev/null
  echo "apiVersion: kubelet.config.k8s.io/v1beta1" | sudo tee -a adm-init.yaml > /dev/null
  echo "cgroupDriver: systemd" | sudo tee -a adm-init.yaml > /dev/null
  fi

}


dk=$(which containerd)
ds=$?
if [[ -z "$mac" ]]
then

if [[  $ds = 0  ]]
then

	if [ ! -z "$d1" ]
	then 
        kubeblock
	kubegist
	kubeinit
        elif [ ! -z "$u1" ]
	then
        kubeblock 
	kubegist
	kubeinit
        fi 
else
   echo "Pls install containerd and re-run this Script"
fi
fi

# end of $ui if
