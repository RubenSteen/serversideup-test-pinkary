#!/bin/sh

DATABASE="$APP_BASE_DIR/storage/database/database.sqlite"

# Check if database.sqlite exists in the storage/database folder
if [ ! -f $DATABASE ]; then
  echo "ℹ️  Creating database.sqlite file..."
  touch $DATABASE
  echo "✅ $DATABASE created successfully"
else
  echo "ℹ️ $DATABASE already exists"
fi

# Exit with a success code
exit 0