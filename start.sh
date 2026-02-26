#!/bin/bash

# Quick start script - sources NVM and runs ng serve
# Usage: ./start.sh

REQUIRED_NODE="v12.22.7"

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Check if nvm is available
if ! command -v nvm &> /dev/null; then
    echo "❌ NVM not found!"
    echo ""
    echo "Please install NVM first by running:"
    echo "  ./setup.sh"
    echo ""
    echo "Or manually install NVM:"
    echo "  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash"
    exit 1
fi

# Use the correct Node version (from .nvmrc)
echo "🔄 Switching to Node $REQUIRED_NODE..."
nvm use

# Verify Node version
CURRENT_NODE=$(node -v)

if [ "$CURRENT_NODE" != "$REQUIRED_NODE" ]; then
    echo "❌ Wrong Node version detected!"
    echo ""
    echo "Current: $CURRENT_NODE"
    echo "Required: $REQUIRED_NODE"
    echo ""
    echo "⚠️  This script cannot change your terminal's Node version."
    echo ""
    echo "Please run these commands in your terminal:"
    echo "  nvm use $REQUIRED_NODE"
    echo "  ng serve -o"
    echo ""
    echo "Or if Node $REQUIRED_NODE is not installed:"
    echo "  nvm install $REQUIRED_NODE"
    echo "  nvm use $REQUIRED_NODE"
    echo "  ng serve -o"
    exit 1
fi

echo "✅ Using Node $CURRENT_NODE"
echo ""

# Check if Angular CLI is available
if ! command -v ng &> /dev/null; then
    echo "❌ Angular CLI not found!"
    echo ""
    echo "Please install it by running:"
    echo "  npm install -g @angular/cli@13.3.11"
    exit 1
fi

# Start the dev server
echo "🚀 Starting Angular dev server..."
NODE_OPTIONS="--max-http-header-size=16000" ng serve -o
