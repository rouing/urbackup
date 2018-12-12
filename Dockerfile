FROM debian:stretch
ENV VERSION 2.2.11
MAINTAINER William C. Ardoin [https://git.rouing.me/docker/urbackup]

RUN apt-get update
RUN apt-get install sqlite3 libcrypto++6 libcurl3 libfuse2 curl  -y

RUN curl https://www.urbackup.org/downloads/Server/$(curl https://www.urbackup.org/downloads/Server/ | grep -oP 'href="\K[0-9]+\.[0-9]+\.[0-9]+' | sort -t. -rn -k1,1 -k2,2 -k3,3 | head -1)/debian/stretch/urbackup-server_$(curl https://www.urbackup.org/downloads/Server/ | grep -oP 'href="\K[0-9]+\.[0-9]+\.[0-9]+' | sort -t. -rn -k1,1 -k2,2 -k3,3 | head -1)_amd64.deb >> /root/urbackup.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i /root/urbackup.deb  || true

ADD backupfolder /etc/urbackup/backupfolder
RUN chmod +x /etc/urbackup/backupfolder

EXPOSE 55413
EXPOSE 55414
EXPOSE 55415
EXPOSE 35623

VOLUME [ "/var/urbackup", "/backup"]
ENTRYPOINT ["/usr/bin/urbackupsrv"]
CMD ["run"]
