# screen -X -S Quili quit
pkill screen
# apt install unzip
# wget http://95.216.228.91/store.zip
# unzip store.zip
# cd ~/ceremonyclient/node/.config
# rm -rf store
# cd ~
# mv store ~/ceremonyclient/node/.config

source /root/.gvm/scripts/gvm
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.17.13
gvm use go1.17.13
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20.2
gvm use go1.20.2

cd ~/ceremonyclient
git pull
git switch release
cd ~/ceremonyclient/node
# 赋予执行权限
chmod +x release_autorun.sh
screen -dmS Quili bash -c './release_autorun.sh'

##删除此文件
cd ~
rm -f restart.sh
