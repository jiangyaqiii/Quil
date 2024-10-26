#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi


echo "\$nrconf{kernelhints} = 0;" >> /etc/needrestart/needrestart.conf
echo "\$nrconf{restart} = 'l';" >> /etc/needrestart/needrestart.conf
echo "ulimit -v 640000;" >> ~/.bashrc
source ~/.bashrc

# 更新并升级Ubuntu软件包
sudo apt update  

# 安装wget、screen和git等组件
sudo apt -yq install git ufw bison screen binutils gcc make bsdmainutils 
sudo apt -yq install util-linux
apt install cpulimit -y

# 安装GVM
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source /root/.gvm/scripts/gvm

gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.17.13
gvm use go1.17.13
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20.2
gvm use go1.20.2

# 克隆仓库
git clone https://source.quilibrium.com/quilibrium/ceremonyclient.git
cd ~/ceremonyclient
# 切换分支
git switch v2.0.0-p3
# 进入ceremonyclient/node目录

cd /root/ceremonyclient/node

# 获取并下载最新的 linux-amd64 文件
for f in $(curl -s https://releases.quilibrium.com/release | grep linux-amd64); do
    echo "Processing $f..."
    
    # 如果文件存在，删除它
    if [ -f "$f" ]; then
        echo "Removing existing file: $f"
        rm "$f"
    fi
    
    # 下载文件
    echo "Downloading $f..."
    curl -s -O "https://releases.quilibrium.com/$f"
done
chmod +x node-2*


cd /root/ceremonyclient/client
# 获取并下载最新的 linux-amd64 文件
for f in $(curl -s https://releases.quilibrium.com/qclient-release | grep linux-amd64); do
    echo "Processing $f..."
    
    # 如果文件存在，删除它
    if [ -f "$f" ]; then
        echo "Removing existing file: $f"
        rm "$f"
    fi
    
    # 下载文件
    echo "Downloading $f..."
    curl -s -O "https://releases.quilibrium.com/$f"
done
chmod +x qclient-2*

systemctl stop quili_monitor.service
cd /root/ceremonyclient/node
screen -dmS quili bash -c ' ./node-2.0.2.1-linux-amd64'

# # ===================================公共模块===监控screen模块======================================================================
# cd ~
# #监控screen脚本
# echo '#!/bin/bash
# while true
# do
#     echo "Screen session not found, restarting..."
#     cd /root/ceremonyclient/node
#     screen -dmS quili bash -c ' ./node-2.0.2-linux-amd64'
#     sleep 1800  # 每隔10秒检查一次
# done' > monit.sh
# ##给予执行权限
# chmod +x monit.sh
# # ================================================================================================================================
# echo '[Unit]
# Description=Quili Monitor Service
# After=network.target

# [Service]
# Type=simple
# ExecStart=/bin/bash /root/monit.sh

# [Install]
# WantedBy=multi-user.target' > /etc/systemd/system/quili_monitor.service
# sudo systemctl daemon-reload
# sudo systemctl enable quili_monitor.service
# sudo systemctl start quili_monitor.service
# sudo systemctl status quili_monitor.service
