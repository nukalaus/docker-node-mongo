from ubuntu:latest

MAINTAINER Eric Greene <eric@training4developers.com>

ENV NODE_VERSION 4.4.0
ENV NODE_ARCHIVE node-v$NODE_VERSION-linux-x64.tar.xz

# Update & Install Ubuntu Packages
RUN apt-get update && apt-get install -y \
		curl \
		xz-utils

# Download Binary Node.js Files
RUN mkdir /opt/downloads; mkdir /opt/app
RUN curl -o /opt/downloads/$NODE_ARCHIVE \
		https://nodejs.org/dist/v$NODE_VERSION/$NODE_ARCHIVE

# Extract and Install Node.js Files
RUN	tar -C /usr/local --strip-components 1 -xf /opt/downloads/$NODE_ARCHIVE

# Setup MongoDB Package Repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
RUN apt-get update

# Install MongoDB
RUN apt-get install -y mongodb-org

COPY assets/startup.sh /usr/sbin
COPY assets/mongod.conf /etc
COPY assets/mongodb /etc/init.d
RUN chown mongodb:mongodb /var/lib/mongodb
RUN chown mongodb:mongodb /var/log/mongodb
RUN chmod +x /etc/init.d/mongodb

EXPOSE 3000
EXPOSE 27017

CMD bash -C '/usr/sbin/startup.sh';'bash'
