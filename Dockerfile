FROM php:8.2-apache

RUN apt update && apt install -y \
    git unzip curl zip libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install || true

RUN cp .env.example .env || true

RUN php artisan key:generate || true

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
