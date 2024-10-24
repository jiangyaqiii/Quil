#!/bin/bash

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

cd /root/ceremonyclient/node
screen -dmS quili bash -c ' ./node-2.0.1-linux-amd64'
