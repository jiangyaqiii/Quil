# ##此脚本未修正内容，有需要修正的内容，会在此处更新


# # 禁用cpu
# # 获取逻辑CPU的数量
# cpu_count=$(lscpu | grep '^CPU(s):' | awk '{print $2}')

# # 检查逻辑CPU的数量是否等于8
# if [ "$cpu_count" -eq 8 ]; then
#   # 如果等于8，执行命令
#   echo "1" > /sys/devices/system/cpu/cpu7/online
#   echo "1" > /sys/devices/system/cpu/cpu6/online
#   echo "1" > /sys/devices/system/cpu/cpu5/online
#   echo "1" > /sys/devices/system/cpu/cpu4/online
# else
#   # echo "0" > /sys/devices/system/cpu/cpu23/online
#   # echo "0" > /sys/devices/system/cpu/cpu22/online
#   # echo "0" > /sys/devices/system/cpu/cpu21/online
#   # echo "0" > /sys/devices/system/cpu/cpu20/online
#   # echo "0" > /sys/devices/system/cpu/cpu19/online
#   # echo "0" > /sys/devices/system/cpu/cpu18/online
#   echo "0" > /sys/devices/system/cpu/cpu17/online
#   echo "0" > /sys/devices/system/cpu/cpu16/online
#   echo "0" > /sys/devices/system/cpu/cpu15/online
#   echo "0" > /sys/devices/system/cpu/cpu14/online
#   # 例如：
#   # echo "执行你的命令"
# fi

# apt install cpulimit -y

# ##因为git地址发生了改变，原git地址不能用了
# echo ""
# echo '停止上一次服务'
# screen -X -S Quili quit
# service ceremonyclient stop

# cd ~/ceremonyclient

# ##切换至新的git地址
# echo ""
# echo '切换至新的git地址'
# git remote set-url origin https://source.quilibrium.com/quilibrium/ceremonyclient.git
# git remote -v
# # git reset --hard 
# # git pull origin/release release 

# ##启动
# cd ~/ceremonyclient/node
# #------------------------计算内存/2的核数，用来运行程序------------------------
# # # 获取系统内存大小（单位为 KB）
# # total_memory_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
# # # 将内存大小转换为 GB
# # total_memory_gb=$(echo "$total_memory_kb / 1024 / 1024" | bc)
# # # 计算内存的一半所需的 CPU 核数
# # half_memory_cores=$(echo "($total_memory_gb / 2)" | bc)
# # echo "全部的内存: $total_memory_gb GB"
# # echo "可使用的核数: $half_memory_cores"
# #------------------------启动服务------------------------
# # screen -dmS Quili bash -c "taskset -c $half_memory_cores ./release_autorun.sh"

# screen -dmS Quili bash -c "./release_autorun.sh"
# echo "================上版本更新内容================"
# echo "================flag:v2================"
# echo "1、git仓库地址发生了变化"
# echo ""
# echo "2、更新到p2挖矿版本，由于每一个线程都会单启一个挖矿程序，单核会用2G左右内存，会导致内存溢出，此次更新限制了quil程序使用的核数"
# echo ""
# echo "================本次更新内容================"
# echo "3、新增cpulimit，无需手动限制内核数，不安装无法正常运行"
# echo ""
# echo "================请注意================"
# echo "请注意，此版本为仍为限制版本，由手动限制改为了官方限制"
# echo ""
# echo "已经启动quil程序,当前版本号为： Quilibrium Node - v1.4.18-p2 – Nebula"
# cd ~
# rm -f correct_screen.sh
# rm -f tmp.txt






# # ================================================================================================================================
# echo "================flag:v4================"
# echo "================更新内容================"
# echo "1、上一版本引入cpulimt模块， 重启会有概率出现内存分页错误：fatal error: failed to reserve page summary memory"
# echo ""
# echo "2、新增监控服务，quil服务掉线之后自动重启"
# echo ""
# echo "3、新增grpcurl，修改了config.yaml配置文件，可以直接在本机进行peer在线查询"
# echo ""
# # ================================以root用户运行脚本================================================================================================
# # 检查是否以root用户运行脚本
# if [ "$(id -u)" != "0" ]; then
#     echo "此脚本需要以root用户权限运行。"
#     echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
#     exit 1
# fi
# # ===================================公共模块===监控screen模块======================================================================
# cd ~
# #监控screen脚本
# echo '#!/bin/bash
# while true
# do
#     if ! screen -list | grep -q "Quili"; then
#         echo "Screen session not found, restarting..."
#         cd /root/ceremonyclient/node
#         screen -dmS Quili bash -c "./release_autorun.sh"
#     fi
#     sleep 10  # 每隔10秒检查一次
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
# # sudo systemctl status quili_monitor.service

# # ===================================增加配置文件，可以查询peer在线情况======================================================================
# echo ''
# echo '将go加入全局环境'
# source /root/.gvm/scripts/gvm
# gvm install go1.4 -B
# gvm use go1.4
# export GOROOT_BOOTSTRAP=$GOROOT
# gvm install go1.17.13
# gvm use go1.17.13
# export GOROOT_BOOTSTRAP=$GOROOT
# gvm install go1.20.2
# gvm use go1.20.2
# echo '查询go的版本号'
# go version
# echo ''
# echo '安装grpcurl'
# go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
# echo ''
# echo '将listenGrpcMultiaddr和listenRESTMultiaddr写入配置文件'
# sed -i 's|listenGrpcMultiaddr: ""|listenGrpcMultiaddr: "/ip4/127.0.0.1/tcp/8337"|' ./ceremonyclient/node/.config/config.yml
# sed -i 's|listenRESTMultiaddr: ""|listenRESTMultiaddr: "/ip4/127.0.0.1/tcp/8338"|' ./ceremonyclient/node/.config/config.yml

# # ===================================清除缓存执行过程======================================================================
# echo "================清除缓存执行过程================"
# echo ""
# echo "关闭上一次会话"
# screen -X -S Quili quit
# echo ""
# echo "清除缓存"
# sudo rm -rf /var/log/*
# sudo rm -rf /tmp/*
# sudo apt-get remove --purge $(dpkg --get-selections l grep -v deinstall |grep -v "linux-image" |awk '{print $1}')
# sudo apt-get -y autoremove
# sudo apt-get -y clean
# cp -r /etc/skel/. /root/
# sudo rm -rf /etc/network/interfaces
# sudo cp /etc/network/interfaces.dpkg-dist /etc/network/interfaces
# sudo update-grub
# # ================================================================================================================================
# echo ""
# echo "修复完成，机器自动重启，无需操作，会自动重启相关服务"
# sudo reboot



# ================================================================================================================================
echo "================flag:v5================"
echo "================更新内容================"
echo "1、内存占用降低，cpu占用升高，cpu成为主导因素"
echo ""
echo "2、node/.config 下新增store文件夹，需要备份的文件现为3份：config.yml, keys.yml, store文件夹"
echo ""
echo "3、可实时查询余额"
echo ""
# ================================================================================================================================
# # 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi
# # ===================================停止监控服务======================================================================
echo '停止监控服务,因为需要更新版本'
echo ''
sudo systemctl stop quili_monitor.service
# # ================================================================================================================================
# # ===================================停止当前会话======================================================================
screen -X -S Quili quit
# # ================================================================================================================================
# # ===================================更新版本代码======================================================================
echo '在 /root/bak 下备份config.yml 和keys.yml 文件'
echo ''
cd ~
mkdir bak
cp /root/ceremonyclient/node/.config/keys.yml /root/bak/
cp /root/ceremonyclient/node/.config/config.yml /root/bak/
echo '备份完毕'
echo ''
# # ================================================================================================================================
# # ===================================更新版本代码======================================================================
cd ~/ceremonyclient/node
git pull
git switch release-cdn
echo '检查当前代码分支是否为 release-cdn'
echo ''
echo '打印当前代码分支'
git branch
echo ''
echo '更新完毕'
# # ================================================================================================================================
# # ===================================启动监控服务======================================================================
echo '启动监控服务'
echo ''
sudo systemctl start quili_monitor.service
sudo systemctl status quili_monitor.service
echo '启动完毕'
echo "已经启动quil程序,当前版本号为：  Quilibrium Node - v1.4.19 – Betelgeuse"
# # ================================================================================================================================



