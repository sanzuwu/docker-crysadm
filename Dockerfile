# 这是迅雷云监工的docker程序
# 云监工原作者powergx

FROM ubuntu:14.04
MAINTAINER sanzuwu <sanzuwu@gmail.com>

RUN /bin/sed -i.bak 's/archive/cn\.archive/' /etc/apt/sources.list
RUN rm /bin/sh &&  ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y git 
RUN mkdir /app 
WORKDIR /app
RUN git clone https://github.com/sanzuwu/crysadm.git
RUN apt-get install -y python3.4 python3.4-dev redis-server
RUN chmod +x ./crysadm/get-pip.py
RUN python3.4 ./crysadm/get-pip.py
RUN pip3.4 install redis && sudo pip3.4 install requests && sudo pip3.4 install flask
RUN apt-get clean 
RUN chmod +x ./crysadm/run.sh ./crysadm/down.sh
VOLUME /var/lib/redis
RUN /etc/init.d/redis-server restart
RUN python3.4 ./crysadm/crysadm/crysadm_helper.py >> /tmp/error 2>&1 &
RUN python3.4 ./crysadm/crysadm/crysadm.py >> /tmp/error 2>&1 &
#CMD ["./crysadm/run.sh"]    

