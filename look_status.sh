#!/bin/bash

if screen -list | grep -q Quili; then
    echo "运行中"
else
    echo "停止"
fi
