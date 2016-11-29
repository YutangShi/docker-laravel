FROM eboraas/apache-php
MAINTAINER Allen Shi <yutangshi@gmail.com>

RUN apt-get update && apt-get -y install git vim curl php5-mcrypt php5-json && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/a2enmod rewrite

ADD ./apache/apache-config.conf /etc/apache2/sites-available/
#ADD 001-laravel-ssl.conf /etc/apache2/sites-available/
RUN /usr/sbin/a2dissite '*' && /usr/sbin/a2ensite apache-config

RUN /usr/bin/curl -sS https://getcomposer.org/installer |/usr/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer
#RUN /usr/local/bin/composer create-project laravel/laravel /var/www/laravel --prefer-dist
#RUN /bin/chown www-data:www-data -R /var/www/laravel/storage /var/www/laravel/bootstrap/cache

EXPOSE 80
#EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
