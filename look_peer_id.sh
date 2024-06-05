#!/bin/bash
echo 'flag:v3'
cd ~/ceremonyclient/node
./node-1.4.18-linux-amd64 -peer-id
cd ~
echo '查询peer在线情况'
wget -O - https://raw.githubusercontent.com/0xOzgur/QuilibriumTools/main/visibility_check.sh | bash
echo ''
echo '若查询报错，请点击【grpcurl】按键进行修复'
echo '若查询报错，请点击【grpcurl】按键进行修复'
rm -f look_peer_id.sh
