# 基础映像
FROM alpine:3.18.2

# 复制脚本
COPY main.sh /opt/alist/main.sh

# 复制版本号
COPY version.txt /opt/alist/version.txt

# 复制时区文件
COPY Shanghai /etc/localtime

# 换国内源
COPY repositories /etc/apk/repositories

# 复制容器启动时执行的文件
COPY entrypoint.sh /entrypoint.sh

# 安装curl，并清理临时文件
RUN apk --no-cache update \
    && apk --no-cache add curl \
    && rm -rf /var/cache/apk/* \
    &&  chmod +x /entrypoint.sh

# 暴露端口
EXPOSE 5244

# 设置工作目录
WORKDIR /home/alist

# 自定义启动命令
# CMD ["/bin/sh", "/home/alist/main.sh"]

# 设置容器的入口点（Entry Point），即容器启动时运行的主要命令或可执行文件。
ENTRYPOINT ["/entrypoint.sh"]
