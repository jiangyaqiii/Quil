
sed -i '/listenMultiaddr: /i\  - /ip4/91.242.214.79/udp/8336/quic-v1/p2p/QmNSGavG2DfJwGpHmzKjVmTD6CVSyJsUFTXsW4JXt2eySR' /root/ceremonyclient/node/.config/config.yml

screen -dmS quili bash -c ' ./node-2.0.2-linux-amd64'
pkill screen
