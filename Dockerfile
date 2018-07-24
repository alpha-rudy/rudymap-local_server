FROM ubuntu:bionic
MAINTAINER Rudy Chung <rudy.chung@liteon.com>

RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list
RUN apt-get update

ENV TZ=Asia/Taipei
RUN echo $TZ > /etc/timezone && apt-get install -y --no-install-recommends tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
RUN echo "dash dash/sh boolean false" | debconf-set-selections; dpkg-reconfigure -f noninteractive dash
RUN apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        bash-completion \
        curl \
        iputils-ping \
        less \
        locales \
        net-tools \
        nginx \
        sudo \
        vim \
        wget \
    && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US.UTF-8
RUN adduser --disabled-password --gecos '' builder && adduser builder sudo
ADD ./rootfs /
RUN chown -R builder:builder /home/builder

RUN rm -rf /var/www/html && \
    ln -sf /mnt/data/html /var/www/html

EXPOSE 80/tcp
VOLUME ["/mnt/data"]

WORKDIR /mnt/data/html

CMD ["run"]
