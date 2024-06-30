#!/bin/bash

# Fail the script if any command fails
set -e

# Print commands and their arguments as they are executed
set -x

echo "Starting PHP application build..."

# Install dependencies using Composer
composer install --no-dev --optimize-autoloader

# Run PHPUnit tests
php vendor/bin/phpunit

# If you have a build process, such as compiling assets
# Uncomment the following line if you use a build tool like Gulp, Grunt, or Webpack
# npm install
# npm run build

# Package the application (optional)
# For example, create a zip file of the application
zip -r myapp.zip . -x "vendor/*" "node_modules/*" "*.git/*" "*.idea/*"

echo "PHP application build completed successfully."
