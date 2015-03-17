### install debian ###
FROM debian:latest
MAINTAINER u.seltmann@gmail.com
EXPOSE 25 143
VOLUME ["/home/dev/Maildir"]
ENTRYPOINT ["/docker/init"]
CMD ["run"]
ENV DEBIAN_FRONTEND noninteractive
# adding dot-deb repository
RUN apt-get update \
 && apt-get -y dist-upgrade

RUN apt-get install -y wget less vim supervisor

RUN apt-get install -y postfix dovecot-imapd procmail

COPY assets/build /docker/build
RUN chmod 755 /docker/build/init \
 && /docker/build/init

COPY assets/setup /docker/setup
COPY assets/run /docker/run
COPY assets/init /docker/init
RUN chmod 755 /docker/init /docker/run/*
