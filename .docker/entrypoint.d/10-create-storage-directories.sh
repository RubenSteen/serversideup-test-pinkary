#!/bin/sh

# Create storage directories if they don't exist
STORAGE_DIRS="storage/app \
storage/app/public \
storage/framework \
storage/framework/cache \
storage/framework/cache/data \
storage/framework/sessions \
storage/framework/testing \
storage/framework/views \
storage/logs \
storage/database"

echo "Creating storage directories if they don't exist..."

for dir in $STORAGE_DIRS; do
    if [ ! -d "/var/www/html/$dir" ]; then
        mkdir -p "/var/www/html/$dir"
        echo "Created: $dir"
    fi
done

echo "Storage directories setup complete."
