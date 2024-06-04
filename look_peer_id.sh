#!/bin/bash
echo 'flag:v3'
cd ~/ceremonyclient/node
./node-1.4.18-linux-amd64 -peer-id
cd ~
rm -f look_peer_id.sh
