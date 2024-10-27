cd /root/ceremonyclient/client
./qclient-2.0.1-linux-amd64 token balance --config ~/ceremonyclient/node/.config/
cp qclient-2.0.1-linux-amd64 ../node/
cp qclient-2.0.1-linux-amd64.dgst ../node/
cd ../node

read -p "请输入接收地址: " rev_addr
read -p "请输入发送数量: " mount
send_addr=$(./qclient-2.0.1-linux-amd64 token coins)
./qclient-2.0.1-linux-amd64 token transfer $send_addr $rev_addr $mount
