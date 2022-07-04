#!/usr/bin/bash
set -E
c1=`sudo systemctl stop kubelet`
c2=`sudo systemctl stop docker`
c3=`sudo rm -rf /var/lib/cni/`
c4=`sudo rm -rf /var/lib/kubelet/*`
c5=`sudo rm -rf /etc/cni/`
c6=`sudo ifconfig cni0 down`
c7=`sudo ifconfig flannel.1 down`
c8=`sudo ifconfig docker0 down`
echo "Done cleaning UP"
