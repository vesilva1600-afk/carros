FROM richarvey/nginx-php-fpm:3.1.6

COPY . /var/www/html

# Configura o Nginx para apontar para a pasta /public do Laravel
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Permite que o Composer rode como root no container
ENV COMPOSER_ALLOW_SUPERUSER 1

# Instala dependências, cria o SQLite vazio (caso alguma rota peça) e ajusta permissões
RUN composer install --no-dev --optimize-autoloader \
    && mkdir -p database \
    && touch database/database.sqlite \
    && chown -R nginx:nginx /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database
