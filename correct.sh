##此脚本未修正内容，有需要修正的内容，会在此处更新

##因为git地址发生了改变，原git地址不能用了
cd ~/ceremonyclient
##切换至新的git地址
git remote set-url origin https://source.quilibrium.com/quilibrium/ceremonyclient.git
git pull
screen -X -S Quili quit
cd ~/ceremonyclient/node

