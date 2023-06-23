#!/bin/sh

# 文件中保存的版本号
current_version=$(cat ./version.txt)

# API地址
api_url="https://api.github.com/repos/alist-org/alist/releases/latest"

# 发起GET请求获取最新版本号
latest_version=$(curl -s "$api_url" | grep -o '"tag_name": ".*"' | cut -d'"' -f4)

# 检查是否成功获取到最新版本号
if [[ -n "$latest_version" ]]; then
  # 比较版本号
  if [ "$latest_version" != "$current_version" ]; then
    echo "发现新版本！最新版本号为：$latest_version" >> ./data/log/log.log

    # 设置新版本下载地址和文件名称
    download_url="https://ghproxy.com/https://github.com/alist-org/alist/releases/latest/download/alist-linux-musl-amd64.tar.gz"
    new_version_file="apan.tar.gz"

    # 下载最新版本
    curl -L "$download_url" -o "$new_version_file"

    # 校验文件是否下载成功
    if [ $? -eq 0 ]; then
      # 解压缩文件
      tar -zxvf "$new_version_file"
      
      # 校验文件是否解压缩成功
      if [ $? -eq 0 ]; then
        # 删除下载的压缩包
        rm -f "$new_version_file"

        # 将最新版本号写入version.txt文件
        echo "$latest_version" > version.txt

      else
        echo "解压缩文件失败。" >> ./data/log/log.log
      fi

    else
      echo "下载文件失败。" >> ./data/log/log.log
    fi
  else
    echo "当前版本已经是最新版本。" >> ./data/log/log.log
  fi
else
  echo "未能获取最新版本号。" >> ./data/log/log.log
fi

# 启动服务器
./alist server
