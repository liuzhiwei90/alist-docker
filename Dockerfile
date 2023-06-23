# 基础映像
FROM alpine:3.18.2

# 复制脚本
COPY main.sh /home/alist/main.sh

# 复制版本号
COPY version.txt /home/alist/version.txt

# 复制时区文件
COPY Shanghai /etc/localtime

# 换国内源
COPY repositories /etc/apk/repositories

# 安装curl
RUN apk --no-cache update \
    && apk --no-cache add curl

# 暴露端口
EXPOSE 5244

# 设置工作目录
WORKDIR /home/alist

# 自定义启动命令
CMD ["/bin/sh", "/home/alist/main.sh"]