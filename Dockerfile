FROM ubuntu:latest


WORKDIR /opt

RUN apt update && \
    apt install wget -y

RUN wget https://releases.mattermost.com/9.4.2/mattermost-9.4.2-linux-amd64.tar.gz && \
    tar -xvf mattermost*.gz && \
    rm mattermost*.gz

COPY config.json /opt/mattermost/config/config.json

RUN mkdir /opt/mattermost/data && \
    mkdir -p /opt/mattermost/client/plugins; \
    mkdir -p /opt/mattermost/plugins; \
    useradd --system --user-group mattermost && \
    chown -R mattermost:mattermost /opt/mattermost && \
    chmod -R g+w /opt/mattermost

RUN DEBIAN_FRONTEND=noninteractive apt install postgresql -y

COPY init.sql .
COPY start_server.sh .

CMD /bin/bash start_server.sh

EXPOSE 8080
