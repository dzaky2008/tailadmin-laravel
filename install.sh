#!/bin/sh
set -e

npm install --legacy-peer-deps --no-audit --progress=false
npm run dev

composer install --optimize-autoloader

cp .env.example .env || true
php artisan key:generate

sed -i 's/DB_HOST=.*/DB_HOST=172.17.0.2/g' .env
sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=password/g' .env

php artisan migrate --force
php artisan db:seed --force
