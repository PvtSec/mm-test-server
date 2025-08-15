FROM ubuntu:jammy


WORKDIR /opt

# ENV MM-VERSION="9.4.2"
ENV MM-VERSION="10.11.1"

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install wget postgresql-14 -y && \
    wget https://releases.mattermost.com/10.11.1/mattermost-10.11.1-linux-amd64.tar.gz && \
    tar -xvf mattermost*.gz && \
    rm mattermost*.gz

COPY config.json /opt/mattermost/config/config.json

RUN mkdir /opt/mattermost/data && \
    mkdir -p /opt/mattermost/client/plugins; \
    mkdir -p /opt/mattermost/plugins; \
    useradd --system --user-group mattermost && \
    chown -R mattermost:mattermost /opt/mattermost && \
    chmod -R g+w /opt/mattermost

COPY init.sql .
COPY start_server.sh .

CMD ["/bin/bash", "start_server.sh"]

EXPOSE 8080
