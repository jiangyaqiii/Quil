#!/bin/bash

if screen -list | grep -q quili; then
    echo "运行中"
else
    echo "停止"
fi
