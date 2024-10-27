cd /root/ceremonyclient/client
echo '显示wquil数量:'
./qclient-2.0.1-linux-amd64 token balance --config ~/ceremonyclient/node/.config/
echo ''
cp qclient-2.0.1-linux-amd64 ../node/
cp qclient-2.0.1-linux-amd64.dgst ../node/

echo '显示发送地址:'
./qclient-2.0.1-linux-amd64 token coins --config ~/ceremonyclient/node/.config/
echo ''

read -p "请输入接收地址: " rev_addr
read -p "请输入发送地址: " send_addr

cd ~/ceremonyclient/node/
./../client/qclient-2.0.1-linux-amd64 token transfer $rev_addr $send_addr
