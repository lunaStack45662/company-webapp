#!/usr/bin/env bash

set -euo pipefail

echo "=== Script started ==="

echo "Current directory:"
pwd

echo
echo "Files:"
ls -la

echo
echo "Go version:"
go version

echo
echo "Building..."
go build -o main .

echo
echo "Running..."
./main