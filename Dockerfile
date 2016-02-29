# 这是迅雷云监工的docker程序
# 云监工原作者powergx

FROM tutum/ubuntu:trusty
MAINTAINER sanzuwu <sanzuwu@gmail.com>
#切换国内源
#RUN /bin/sed -i.bak 's/archive/cn\.archive/' /etc/apt/sources.list
RUN rm /bin/sh &&  ln -s /bin/bash /bin/sh
#更新，安装git，wget，sudo
RUN apt-get update && apt-get install -y git wget sudo
#启动ssh服务
#RUN service ssh start
#创建工作目录
RUN mkdir /app 
WORKDIR /app
#下载云监工源代码
RUN git clone https://github.com/sanzuwu/crysadm.git
#redis数据库保存目录
VOLUME ["/var/lib/redis"]
#安装python，redis
RUN apt-get install -y python3.4 python3.4-dev redis-server
RUN chmod +x ./crysadm/get-pip.py
RUN python3.4 ./crysadm/get-pip.py
RUN pip3.4 install redis && sudo pip3.4 install requests && sudo pip3.4 install flask
RUN apt-get clean 
#脚本加运行权限
RUN chmod +x ./crysadm/run.sh ./crysadm/down.sh ./crysadm/setup.sh
#设置容器端口
#云监工端口
EXPOSE 4000
#ssh端口
EXPOSE 22
#运行云监工
#RUN /etc/init.d/redis-server restart
#RUN python3.4 ./crysadm/crysadm/crysadm_helper.py  &
#RUN python3.4 ./crysadm/crysadm/crysadm.py &
#CMD ["python3.4","crysadm/crysadm/crysadm_helper.py  &","crysadm/crysadm/crysadm.py  &"]    
#CMD ["/app/crysadm/run.sh"]
