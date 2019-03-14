#Docker image of elasticsearch-head
# VERSION 6

#基础镜像使用node:10.15.0，以便通过npm来安装head插件
FROM node:10.15.0-alpine

#作者
MAINTAINER Belonghaung <belonghuang@gmail.com>

#定义下载源文件的路径
ENV SRC_DOWN_PATH /usr/src/app

#创建文件夹用于保存下载的源码
RUN mkdir -p $SRC_DOWN_PATH && \
#进入该文件夹
cd $SRC_DOWN_PATH && \
#下载源码
wget https://codeload.github.com/mobz/elasticsearch-head/zip/master && \
#解压
unzip master && \
#解压后，压缩文件可以删除了
rm master && \
#进入解压后的文件夹
cd elasticsearch-head-master && \
#设置为taobao，加速npm安装速度
npm config set registry http://registry.npm.taobao.org && \
#安装grunt
npm install -g grunt-cli && \
#安装head
npm install

#设置默认工作目录为解压后的源码文件夹
WORKDIR $SRC_DOWN_PATH/elasticsearch-head-master

#保留9100端口
EXPOSE 9100

#启动时即启动head服务
CMD [ "grunt", "server" ]
