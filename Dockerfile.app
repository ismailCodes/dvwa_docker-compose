FROM php:7-apache

RUN apt-get update -y
RUN apt-get install -y libfreetype6-dev
RUN apt-get install -y libjpeg62-turbo-dev
RUN apt-get install -y libpng-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN echo "magic_quotes_gpc = Off" >> "$PHP_INI_DIR/php.ini"
RUN echo "allow_url_include = On" >> "$PHP_INI_DIR/php.ini"

COPY --chown=www-data:www-data ./ /var/www/html/
