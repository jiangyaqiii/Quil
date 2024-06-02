#------------------------停止上一个会话------------------------
screen -X -S Quili quit

#------------------------将go设为全局变量------------------------
source /root/.gvm/scripts/gvm
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.17.13
gvm use go1.17.13
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20.2
gvm use go1.20.2

cd ~/ceremonyclient/node
# 赋予执行权限
# chmod +x release_autorun.sh
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
screen -dmS Quili bash -c " ./release_autorun.sh"

##删除此文件
cd ~
rm -f restart.sh
