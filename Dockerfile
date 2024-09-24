FROM php:8.2-fpm  
# Menggunakan PHP 8.2

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Set working directory
WORKDIR /var/www/html/src  
# <-- Ubah direktori kerja ke src

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy existing application directory contents
COPY . /var/www/html/src   
# <-- Ubah sesuai folder src

# Copy existing application directory permissions
RUN chown -R www-data:www-data /var/www/html/src

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
