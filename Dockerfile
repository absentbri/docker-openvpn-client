FROM ich777/debian-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-openvpn-client"

# Install openvpn
RUN apt-get update && \
    apt-get -y install --no-install-recommends curl openvpn tzdata iptables kmod iputils-ping && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -s /bin/bash vpn

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
             CMD curl -LSs 'https://api.ipify.org'

VOLUME ["/vpn"]

ENTRYPOINT ["/opt/scripts/start.sh"]