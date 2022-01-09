FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

# Install openvpn
RUN apt-get update && \
    apt-get -y install --no-install-recommends curl openvpn tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -s /bin/bash vpn

ADD openvpn.sh /opt/scripts/

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
             CMD curl -LSs 'https://api.ipify.org'

VOLUME ["/vpn"]

ENTRYPOINT ["/opt/scripts/openvpn.sh"]