#!/bin/bash
set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh)
source <(curl -s https://raw.githubusercontent.com/rangapv/k8s/master/kube_calico/calctl.sh)

kubecalico() {

  kubectl apply -f https://raw.githubusercontent.com/rangapv/k8s/master/kube_calico/kube-calico.yaml 

}


kc=`which kubectl`
ks= echo "$?"
if [[ $ks -eq 0 ]]
then
     kubecalico
else
	echo "kubectl is not installed or cofigured"
fi
