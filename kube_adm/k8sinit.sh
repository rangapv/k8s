#!/bin/bash
set -E
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
kubeinit() {

	init1=$( sudo kubeadm init --config=./adm-init.yaml | sudo tee ./flag.txt)
	init2=$( mkdir -p $HOME/.kube)
	init3=$( sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config)
	init2=$( sudo chown $(id -u):$(id -g) $HOME/.kube/config)
        echo "Check the flag.txt for tokens to join the master"
}

dk=$(which containerd)
ds=$?
if [[ -z "$mac" ]]
then

if [[  $ds = 0  ]]
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
   echo "Pls install containerd and re-run this Script"
fi
fi

