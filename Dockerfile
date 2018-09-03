FROM php:latest

CMD ["composer", "install"]

RUN set -x && \
    apt-get update -yqq && \
    apt-get install git wget unzip nodejs libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev -yqq && \
    docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        xvfb \
        google-chrome-stable

ADD scripts/xvfb-chrome /usr/bin/xvfb-chrome
RUN ln -sf /usr/bin/xvfb-chrome /usr/bin/google-chrome

ENV CHROME_BIN /usr/bin/google-chrome

WORKDIR /usr/laravel
ENTRYPOINT ["docker-php-entrypoint"]
