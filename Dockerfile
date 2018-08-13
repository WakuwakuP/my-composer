FROM ubuntu:18.04

CMD ["composer install"]

RUN set -x && \
    apt-get update && \
    apt-get install -y softwara-properties-common && \
    sudo add-apt-repository ppa:ondrej/php && \
    sudo apt update && \
    apt-get install -y language-pack-ja && \
    update-locale LANG=ja_JP.UTF-8 LANGUAGE=”ja_JP:ja” && \
    apt-get install -y curl nodejs npm php7.2.7 php7.2.7-common php7.2.7-cli php7.2.7-fpm php7.2.7-mysql php7.2.7-dev php7.2.7-mbstring php7.2.7-zip php-xdebug && \
    echo zend_extension = "/usr/lib/php/20151012/xdebug.so" >> /etc/php/7.2.7/cli/php.ini && \
    echo xdebug.remote_enable=on >> /etc/php/7.2.7/cli/php.ini && \
    npm cache clean && \
    npm install n -g && \
    n 8.11.3 && \
    apt-get purge -y nodejs npm && \
    ln -sf /usr/local/bin/node /usr/bin/node && \
    ln -sf /usr/local/bin/npm /usr/bin/npm && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

WORKDIR /usr/laravel
