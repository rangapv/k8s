#!/bin/bash
set -E
cs1=`sudo curl -o /usr/local/bin/calicoctl -O -L  "https://github.com/projectcalico/calicoctl/releases/download/v3.19.1/calicoctl" `
cs2=`sudo chmod +x /usr/local/bin/calicoctl`
