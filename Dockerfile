FROM centos:7.6.1810

MAINTAINER Jasonli

ENV COBBLER_VERSION 2.8.4
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
RUN curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
RUN curl -o /etc/yum.repos.d/cobbler28.repo http://download.opensuse.org/repositories/home:/libertas-ict:/cobbler28/CentOS_7/home:libertas-ict:cobbler28.repo
RUN yum -y install wget && \
    yum -y install vim lsof links cobbler tftp-server dhcp openssl cobbler-web fence-agents supervisor  pykickstart && \
    yum -y update && \
    yum clean all

ADD debmirror.conf /etc/debmirror.conf
ADD supervisord.d/conf.ini /etc/supervisord.d/conf.ini
ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
