#!/bin/sh

# 文件中保存的版本号
saved_version=$(cat ./version.txt)

# 发起GET请求获取最新版本号
latest_version=$(curl -s "https://api.github.com/repos/alist-org/alist/releases/latest" | grep -o '"tag_name": ".*"' | cut -d'"' -f4)

# 检查是否成功获取到最新版本号
if [[ -n "$latest_version" ]]; then
    # 比较版本号
    if [ "$latest_version" != "$saved_version" ]; then
      echo "发现新版本！最新版本号为：$latest_version" >> ./data/log/log.log
      # 执行一些操作，如下载新版本或执行更新脚本
      curl -L https://ghproxy.com/https://github.com/alist-org/alist/releases/latest/download/alist-linux-musl-amd64.tar.gz -o apan.tar.gz
      tar -zxvf apan.tar.gz
      rm -f apan.tar.gz
      # 将最新版本号写入version.txt文件
      echo "$latest_version" > version.txt
      ./alist server
    else
      echo "当前版本已经是最新版本。" >> ./data/log/log.log
      ./alist server
    fi
else
    echo "未能获取最新版本号。" >> ./data/log/log.log
    ./alist server
fi
