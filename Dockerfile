FROM php:apache

EXPOSE 80

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
  unzip \
  libglu1-mesa

COPY build/web/ /var/www/html/

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite

COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

CMD ["apache2-foreground"]
