##此脚本未修正内容，有需要修正的内容，会在此处更新

##因为git地址发生了改变，原git地址不能用了
screen -X -S Quili quit

cd ~/ceremonyclient

##切换至新的git地址
git remote set-url origin https://source.quilibrium.com/quilibrium/ceremonyclient.git
# git reset --hard 
# git pull origin/release release 

##启动
cd ~/ceremonyclient/node
#------------------------计算内存/2的核数，用来运行程序------------------------
# # 获取系统内存大小（单位为 KB）
# total_memory_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
# # 将内存大小转换为 GB
# total_memory_gb=$(echo "$total_memory_kb / 1024 / 1024" | bc)
# # 计算内存的一半所需的 CPU 核数
# half_memory_cores=$(echo "($total_memory_gb / 2)" | bc)
# echo "全部的内存: $total_memory_gb GB"
# echo "可使用的核数: $half_memory_cores"
#------------------------启动服务------------------------
# screen -dmS Quili bash -c "taskset -c $half_memory_cores ./release_autorun.sh"

screen -dmS Quili bash -c "./release_autorun.sh"
echo "已经启动quil程序，使用screen -r Quili 查看日志"
cd ~
rm -f correct.sh
