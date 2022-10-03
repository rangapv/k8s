#!/usr/bin/bash
set -E
source <(curl -s https://raw.githubusercontent.com/rangapv/runtimes/main/checkruntime.sh)
c1=`sudo systemctl stop kubelet`
c2=`sudo systemctl stop docker`
c3=`sudo rm -rf /var/lib/cni/`
c4=`sudo rm -rf /var/lib/kubelet/*`
c5=`sudo rm -rf /etc/cni/`

if ([[ $Flag -eq 1 ]] && [[ $crun -eq 1 ]])
then
	stopcotd=`sudo systemctl stop containerd`
elif [[ $Dflag -eq 1 ]]
then
c6=`sudo ifconfig cni0 down`
c7=`sudo ifconfig flannel.1 down`
c8=`sudo ifconfig docker0 down`
else
	echo ""
fi
echo "Done cleaning UP"
