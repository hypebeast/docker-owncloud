FROM ubuntu:trusty
MAINTAINER sebastian.ruml@gmail.com

# Install packages
RUN apt-get update \
 && apt-get install -y supervisor logrotate nginx mysql-client git rsync openssh-client \
      php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl \
      php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient \
 && update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
 && rm -rf /var/lib/apt/lists/*

ADD assets/setup/ /app/setup/
RUN chmod 755 /app/setup/install
RUN /app/setup/install

ADD assets/config/ /app/setup/config/
ADD assets/init /app/init
RUN chmod 755 /app/init

EXPOSE 80

# Add VOLUMESs to allow backup and customization of config
VOLUME ["/home/owncloud/owncloud"]

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
