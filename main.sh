#!/bin/sh

curl -L https:/apan-update.liuzw.cn/ -o apan.tar.gz
tar -zxvf apan.tar.gz
rm -f apan.tar.gz
./alist server
