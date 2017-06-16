# Image
FROM ubuntu:16.04

#Information sur le propri?taire du container
MAINTAINER n.wallerand@gmail.com

VOLUME ["/var/www/html"]

# Commande RUN utilise uniquement lors de la creation du container (necessite un docker build)
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y \
      apache2 \
      curl \
      php7.0 \
      php7.0-cli \
      libapache2-mod-php7.0 \
      php7.0-gd \
      php-curl \    
      php-imagick \ 
      php7.0-json \
      php7.0-ldap \
      php7.0-mbstring \
      php7.0-mysql \
      php7.0-pgsql \
      php7.0-sqlite3 \
      php7.0-xml \
      php7.0-xsl \
      php7.0-zip \
      php7.0-soap \
      telnet elinks openssh-server nano

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer 

# Creation variable
#ENV VARIABLE ma-variable

# On expose le port SSH pour pouvoir se connecter sur la machine
#EXPOSE 22

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

#  On ajoute le contenue de l' application dans le repertoire de apache
ADD app /var/www/html

# PORT 80 Ouvert
EXPOSE  80

CMD ["/usr/local/bin/run"]
