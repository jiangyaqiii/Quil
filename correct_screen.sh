##此脚本未修正内容，有需要修正的内容，会在此处更新

echo "================更新内容================"
echo "1、git仓库地址发生了变化"
echo ""
echo "2、更新到p2挖矿版本，由于每一个线程都会单启一个挖矿程序，单核会用2G左右内存，会导致内存溢出，此次更新限制了quil程序使用的核数"
echo ""
echo "================请注意================"
echo "请注意，此版本为限制版本，以内存为基准，限制cpu比例为：cpu:mem=1:2"
# 禁用cpu
# 获取逻辑CPU的数量
cpu_count=$(lscpu | grep '^CPU(s):' | awk '{print $2}')

# 检查逻辑CPU的数量是否等于8
if [ "$cpu_count" -eq 8 ]; then
  # 如果等于8，执行命令
  echo "0" > /sys/devices/system/cpu/cpu7/online
  echo "0" > /sys/devices/system/cpu/cpu6/online
  echo "0" > /sys/devices/system/cpu/cpu5/online
  echo "0" > /sys/devices/system/cpu/cpu4/online
else
  echo "0" > /sys/devices/system/cpu/cpu23/online
  echo "0" > /sys/devices/system/cpu/cpu22/online
  echo "0" > /sys/devices/system/cpu/cpu21/online
  echo "0" > /sys/devices/system/cpu/cpu20/online
  echo "0" > /sys/devices/system/cpu/cpu19/online
  echo "0" > /sys/devices/system/cpu/cpu18/online
  echo "0" > /sys/devices/system/cpu/cpu17/online
  echo "0" > /sys/devices/system/cpu/cpu16/online
  echo "0" > /sys/devices/system/cpu/cpu15/online
  echo "0" > /sys/devices/system/cpu/cpu14/online
  echo "0" > /sys/devices/system/cpu/cpu13/online
  echo "0" > /sys/devices/system/cpu/cpu12/online
  echo "0" > /sys/devices/system/cpu/cpu11/online
  echo "0" > /sys/devices/system/cpu/cpu10/online
  echo "0" > /sys/devices/system/cpu/cpu9/online
  echo "0" > /sys/devices/system/cpu/cpu8/online
  echo "0" > /sys/devices/system/cpu/cpu7/online 
  # 例如：
  # echo "执行你的命令"
fi

apt install cpulimit -y

##因为git地址发生了改变，原git地址不能用了
echo ""
echo '停止上一次服务'
screen -X -S Quili quit

cd ~/ceremonyclient

##切换至新的git地址
echo ""
echo '切换至新的git地址'
git remote set-url origin https://source.quilibrium.com/quilibrium/ceremonyclient.git
git remote -v
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
echo ""
echo "已经启动quil程序,当前版本号为： Quilibrium Node - v1.4.18-p2 – Nebula"
cd ~
rm -f correct_screen.sh
rm -f tmp.txt
