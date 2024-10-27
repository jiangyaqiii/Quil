cd /root/ceremonyclient/client
echo '显示wquil数量:'
./qclient-2.0.1-linux-amd64 token balance --config ~/ceremonyclient/node/.config/
echo ''
cp qclient-2.0.1-linux-amd64 ../node/
cp qclient-2.0.1-linux-amd64.dgst ../node/
cd ../node

echo '显示发送地址:'
send_addr=$(./qclient-2.0.1-linux-amd64 token coins)
echo ''
read -p "请输入接收地址: " rev_addr
read -p "请输入发送地址: " send_addr
read -p "请输入发送数量: " mount
./qclient-2.0.1-linux-amd64 token transfer $send_addr $rev_addr $mount
