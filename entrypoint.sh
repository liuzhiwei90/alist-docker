#!/bin/sh

# 判断main.sh是否存在
if [ ! -f "/home/alist/main.sh" ]; then
    cp /opt/alist/main.sh /home/alist/main.sh
    cp /opt/alist/version.txt /home/alist/version.txt
    chmod +x /home/alist/main.sh
fi

# 运行自定义启动命令
exec /bin/sh /home/alist/main.sh
