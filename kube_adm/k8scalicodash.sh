#!/bin/bash
set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh)

kubecalico() {

  kubectl apply -f https://raw.githubusercontent.com/rangapv/k8s/master/kube_calico/kube-calico.yaml 

}

kubedash() {

  kubectl apply -f https://raw.githubusercontent.com/rangapv/k8s/master/kube_dash/recommended.yaml
  kubectl apply -f https://raw.githubusercontent.com/rangapv/k8s/master/kube_dash/dashboard-adminuser.yaml

}

kc=`which kubectl`
ks= echo "$?"
if [[ $ks -eq 0 ]]
then
     kubecalico
     kubedash
else
	echo "kubectl is not installed or cofigured"
fi
