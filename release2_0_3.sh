screen -X -S Quili quit
cd ~/ceremonyclient
git pull
git switch v2.0.0-p3
cd ~/ceremonyclient/node
screen -X -S Quili quit
screen -d -m -S Quili bash -c "./node-2.0.0.3-linux-amd64"

##删除此文件
cd ~
rm -f release2_0_3.sh
