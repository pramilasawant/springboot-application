#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Print commands and their arguments as they are executed.
set -x

echo "Starting PHP application build..."

# Ensure that PHP and Composer are installed
if ! [ -x "$(command -v php)" ]; then
  echo "PHP is not installed. Installing..."
  sudo apt-get update
  sudo apt-get install -y php
fi

if ! [ -x "$(command -v composer)" ]; then
  echo "Composer is not installed. Installing..."
  EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

  if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
      >&2 echo 'ERROR: Invalid installer checksum'
      rm composer-setup.php
      exit 1
  fi

  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  rm composer-setup.php
fi

# Install dependencies and optimize the autoloader
composer install --no-dev --optimize-autoloader

echo "PHP application build completed successfully."
