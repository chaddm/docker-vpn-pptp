FROM google/debian:wheezy
MAINTAINER Tony.Shao <xiocode@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && apt-get install --no-install-recommends -y -q pptpd iptables rsyslog

COPY ./etc/pptpd.conf /etc/pptpd.conf
COPY ./etc/ppp/pptpd-options /etc/ppp/pptpd-options

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pptpd", "--fg"]
