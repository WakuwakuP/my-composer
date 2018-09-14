FROM php:latest

CMD ["composer", "install"]

RUN set -x && \
    apt-get update -yqq && \
    apt-get install apt-file git wget unzip libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev -yqq && \
    docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache && \
    apt-get install build-essential gnupg2 -yqq && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install nodejs -yqq && \
    npm i npm -g && \
    apt-get install chromium firefox-esr -yqq && \
    wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" && \
    mkdir /opt/firefox && \
    tar xjf FirefoxSetup.tar.bz2 -C /opt/firefox/ && \
    mv /usr/lib/firefox-esr/firefox-esr /usr/lib/firefox-esr/firefox-esr_orig && \
    ln -s /opt/firefox/firefox/firefox /usr/lib/firefox-esr/firefox-esr && \
    apt-get install fonts-ipafont-gothic fonts-ipafont-mincho -yqq && \
    mkdir -p /usr/share/man/man1 && \
    apt-get install openjdk-8-jdk -yqq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd

WORKDIR /usr/laravel
ENTRYPOINT ["docker-php-entrypoint"]
