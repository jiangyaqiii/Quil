#!/bin/bash
echo '=================flag:v4================='
cd ~/ceremonyclient/node
./node-1.4.18-linux-amd64 -peer-id
cd ~
echo ''
echo '========================================='
echo '查询peer在线情况'
source /root/.gvm/scripts/gvm
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.17.13
gvm use go1.17.13
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20.2
gvm use go1.20.2
echo '========================================='
wget -O - https://raw.githubusercontent.com/0xOzgur/QuilibriumTools/main/visibility_check.sh | bash
echo ''
echo '若查询报错，请点击【grpcurl】按键进行修复'
echo '修复之后，需要等待几分钟，若再次查询仍报错，或显示不在线，请联系客服'
rm -f look_peer_id.sh
