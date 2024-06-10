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

# 增加swap空间
sudo mkdir /swap
sudo fallocate -l 24G /swap/swapfile
sudo chmod 600 /swap/swapfile
sudo mkswap /swap/swapfile
sudo swapon /swap/swapfile
echo '/swap/swapfile swap swap defaults 0 0' >> /etc/fstab

# 向/etc/sysctl.conf文件追加内容
echo -e "\n# 自定义最大接收和发送缓冲区大小" >> /etc/sysctl.conf
echo "net.core.rmem_max=600000000" >> /etc/sysctl.conf
echo "net.core.wmem_max=600000000" >> /etc/sysctl.conf

echo "配置已添加到/etc/sysctl.conf"

# 重新加载sysctl配置以应用更改
sysctl -p

echo "sysctl配置已重新加载"

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
# git clone https://github.com/quilibriumnetwork/ceremonyclient
git clone https://source.quilibrium.com/quilibrium/ceremonyclient.git
# git clone https://github.com/a3165458/ceremonyclient.git
cd ~/ceremonyclient
# 切换分支
git switch release-cdn
# 进入ceremonyclient/node目录
cd ~/ceremonyclient/node 
# 赋予执行权限
chmod +x release_autorun.sh
# 创建一个screen会话并运行命令

#------------------------启动服务------------------------
# screen -dmS Quili bash -c "./release_autorun.sh"
# ===================================公共模块===监控screen模块======================================================================
cd ~
#监控screen脚本
echo '#!/bin/bash
while true
do
    if ! screen -list | grep -q "Quili"; then
        echo "Screen session not found, restarting..."
        cd /root/ceremonyclient/node
        screen -dmS Quili bash -c "./release_autorun.sh"
    fi
    sleep 10  # 每隔10秒检查一次
done' > monit.sh
##给予执行权限
chmod +x monit.sh
# ================================================================================================================================
echo '[Unit]
Description=Quili Monitor Service
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /root/monit.sh

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/quili_monitor.service
sudo systemctl daemon-reload
sudo systemctl enable quili_monitor.service
sudo systemctl start quili_monitor.service
sudo systemctl status quili_monitor.service

#============================================================================================================================================================
echo "================上版本更新内容================"
echo "================flag:v4================"
echo "1、git仓库地址发生了变化"
echo ""
echo "2、更新到p2挖矿版本，由于每一个线程都会单启一个挖矿程序，单核会用2G左右内存，会导致内存溢出，此次更新限制了quil程序使用的核数"
echo ""
echo "================本次更新内容================"
echo "3、新增cpulimit，无需手动限制内核数，不安装无法正常运行"
echo ""
echo "================请注意================"
echo "请注意，此版本为仍为限制版本，由手动限制改为了官方限制"
#============================================================================================================================================================

##删除此文件
cd ~
echo "1"
rm -f start.sh
echo "2"
