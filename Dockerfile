from training4developers/node:latest

MAINTAINER Eric Greene <eric@training4developers.com>

# Update & Install Ubuntu Packages
RUN apt-get update && apt-get install -y \
		python \
		build-essential \
		checkinstall

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
