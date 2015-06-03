FROM phusion/baseimage:latest
MAINTAINER Tony.Shao <xiocode@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && apt-get install --no-install-recommends -y -q pptpd iptables syslog-ng
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./etc/pptpd.conf /etc/pptpd.conf
COPY ./etc/ppp/pptpd-options /etc/ppp/pptpd-options

RUN mkdir -p /etc/my_init.d
COPY entrypoint.sh /etc/my_init.d/entrypoint.sh
RUN chmod 0700 /etc/my_init.d/entrypoint.sh

RUN mkdir /etc/service/pptpd
ADD pptpd.sh /etc/service/pptpd/run
RUN chmod 0700 /etc/service/pptpd/run

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
