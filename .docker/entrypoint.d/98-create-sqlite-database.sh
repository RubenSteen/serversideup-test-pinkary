#!/bin/sh
# Check if database.sqlite exists in the database folder
if [ ! -f "$APP_BASE_DIR/database/database.sqlite" ]; then
  echo "ℹ️  Creating database.sqlite file..."
  touch "$APP_BASE_DIR/database/database.sqlite"
  echo "✅ database.sqlite created successfully"
else
  echo "ℹ️  database.sqlite already exists"
fi

# Exit with a success code
exit 0