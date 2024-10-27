cd /root/ceremonyclient/client
mount=$(./qclient-2.0.1-linux-amd64 token balance --config ~/ceremonyclient/node/.config/)
echo '拥有wquil数量:$mount'
cp qclient-2.0.1-linux-amd64 ../node/
cp qclient-2.0.1-linux-amd64.dgst ../node/
cd ../node

read -p "请输入接收地址: " rev_addr
read -p "请输入接收地址: " rev_addr
send_addr=$(./qclient-2.0.1-linux-amd64 token coins)
./qclient-2.0.1-linux-amd64 token transfer $send_addr $rev_addr $mount
