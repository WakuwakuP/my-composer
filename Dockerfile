FROM php:latest

CMD ["composer", "install"]

RUN set -x && \
    apt-get update -yqq && \
    apt-get install apt-file git wget unzip libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev -yqq && \
    docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache && \
    apt-get install software-properties-common -yqq && \
    add-apt-repository ppa:chromium-daily/stable && \
    apt-get update && \
    apt-get install chromium -y && \
    apt-get install fonts-ipafont-gothic fonts-ipafont-mincho -y && \
    apt-get install nodejs npm -yqq && \
    npm install n -g && \
    n 8.11.3 && \
    apt-get purge -y nodejs npm && \
    ln -sf /usr/local/bin/node /usr/bin/node && \
    ln -sf /usr/local/bin/npm /usr/bin/npm && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd

WORKDIR /usr/laravel
ENTRYPOINT ["docker-php-entrypoint"]
