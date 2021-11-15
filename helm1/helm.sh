#!/bin/bash
set -E
shlmv=0

helmins() {
dh=`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3`
cm=`chmod 700 ./get_helm.sh`
insh=`./get_helm.sh`
sinsh="$?"
}

chkhlm() {
hlmv=`helm version`
shlmv="$?"
}


chkhlm
if [[ (( $shlmv -ne 0 )) ]]
then
        echo "Greenfiled helm install"
	helmins
else
        echo "helm installed & ready"
	echo "$hlmv"
fi
chkhlm
