#!/bin/bash

export PGDATA="/var/lib/postgresql/14/data"
export POSTGRES_DB=mattermost
export POSTGRES_USER=mmuser
export POSTGRES_PASSWORD=testPassword

rm -rf $PGDATA; mkdir -p $PGDATA
chown -R postgres:postgres /var/lib/postgresql

su postgres -c "/usr/lib/postgresql/14/bin/initdb -D $PGDATA"
su postgres -c "/usr/lib/postgresql/14/bin/pg_ctl -D $PGDATA start"
su postgres -c "psql -c \"CREATE DATABASE mattermost;\""
su postgres -c "psql -c \"CREATE USER mmuser WITH PASSWORD 'mmpassword';\""
su postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE mattermost TO mmuser;\""

su postgres -c "psql -d mattermost -U mmuser -f /opt/init.sql"

cd /opt/mattermost
su mattermost -c "bin/mattermost"
