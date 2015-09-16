FROM ubuntu:latest
MAINTAINER Tony.Shao <xiocode@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -qqy pptpd iptables && apt-get clean

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh

EXPOSE 1723 47

ENTRYPOINT ["/entrypoint.sh"]
