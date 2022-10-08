#!/bin/bash
set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh)

kubeflannel() {

  kubectl apply -f https://raw.githubusercontent.com/rangapv/k8s/master/kube_flannel/kube-flannel.yml

}

kc=`which kubectl`
ks= echo "$?"
if [[ $ks -eq 0 ]]
then
     kubeflannel
else
     echo "kbectl is not installed or cofigured"
fi
