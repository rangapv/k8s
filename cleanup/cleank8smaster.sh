#!/usr/bin/bash
set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/checkruntime.sh)
source <(curl -s https://raw.githubusercontent.com/rangapv/kubestatus/main/ks.sh) 

n1=`hostname`
if [[ ( $node -eq 1 ) ]]
then
	unjoin=`kubectl drain $n1`
	unjoin2=`kubectl delete node $n1`
	unjoin3=`kubeadm reset`
fi


c1=`sudo systemctl stop kubelet`
c3=`sudo rm -rf /var/lib/cni/`
c4=`sudo rm -rf /var/lib/kubelet/*`
c5=`sudo rm -rf /etc/cni/`
c6=`sudo rm -rf /etc/kubernetes/`

if ([[ $Flag -eq 1 ]] && [[ $crun -eq 1 ]])
then
	stopcotd=`sudo systemctl stop containerd`
elif [[ $Dflag -eq 1 ]]
then
c2=`sudo systemctl stop docker`
c6=`sudo ifconfig cni0 down`
c7=`sudo ifconfig flannel.1 down`
c8=`sudo ifconfig docker0 down`
else
	echo ""
fi
echo "Done cleaning UP"
