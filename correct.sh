##此脚本未修正内容，有需要修正的内容，会在此处更新

##因为git地址发生了改变，原git地址不能用了
screen -X -S Quili quit

cd ~/ceremonyclient

##分配给git 5G的内存，避免拉取代码时报错
git config --global pack.windowMemory 5g
git config --global pack.packSizeLimit 5g
git config --global pack.window 0
git config --global core.packedGitLimit 5g
git config --global core.packedGitWindowSize 5g

##切换至新的git地址
git remote set-url origin https://source.quilibrium.com/quilibrium/ceremonyclient.git.

##拉取最新的代码
git pull

##限制每个线程的占用内存数量
echo 'ulimit -v 640000' >> ~/.bashrc
source ~/.bashrc

##启动
cd ~/ceremonyclient/node
screen -dmS Quili bash -c './release_autorun.sh'

cd ~
rm -f correct.sh
