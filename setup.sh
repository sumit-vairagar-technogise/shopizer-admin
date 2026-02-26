#!/bin/bash

# Shopizer Admin Setup Script
# This script helps onboard developers by setting up the correct environment

set -e

echo "🚀 Shopizer Admin Setup Script"
echo "================================"
echo ""

# Function to load nvm
load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

# Check if nvm is installed
load_nvm

if ! command -v nvm &> /dev/null; then
    echo "📥 NVM not found. Installing NVM..."
    
    # Install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    
    # Load nvm for current session
    load_nvm
    
    # Verify installation
    if ! command -v nvm &> /dev/null; then
        echo "❌ NVM installation failed. Please install manually:"
        echo "   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash"
        echo "   Then restart your terminal and run this script again."
        exit 1
    fi
    
    echo "✅ NVM installed successfully"
else
    echo "✅ NVM found"
fi

echo ""

# Check current Node version
CURRENT_NODE=$(node -v 2>/dev/null || echo "none")
REQUIRED_NODE="v12.22.7"

echo "📦 Current Node version: $CURRENT_NODE"
echo "📦 Required Node version: $REQUIRED_NODE"
echo ""

# Install required Node version if not present
if ! nvm list | grep -q "$REQUIRED_NODE"; then
    echo "📥 Installing Node $REQUIRED_NODE..."
    nvm install $REQUIRED_NODE
else
    echo "✅ Node $REQUIRED_NODE already installed"
fi

# Use the required Node version
echo "🔄 Switching to Node $REQUIRED_NODE..."
nvm use $REQUIRED_NODE

# Reload nvm to ensure paths are updated
load_nvm

# Verify Node version
ACTIVE_NODE=$(node -v)
if [ "$ACTIVE_NODE" != "$REQUIRED_NODE" ]; then
    echo "❌ Failed to switch to Node $REQUIRED_NODE"
    exit 1
fi

echo "✅ Using Node $ACTIVE_NODE"
echo ""

# Check if Angular CLI is installed globally
if ! command -v ng &> /dev/null; then
    echo "📥 Installing Angular CLI globally..."
    npm install -g @angular/cli@13.3.11
else
    NG_VERSION=$(ng version 2>/dev/null | grep "Angular CLI" | awk '{print $3}' || echo "unknown")
    echo "✅ Angular CLI found (version: $NG_VERSION)"
fi

echo ""

# Clean up existing node_modules and package-lock
if [ -d "node_modules" ]; then
    echo "🧹 Cleaning up existing node_modules..."
    rm -rf node_modules
fi

if [ -f "package-lock.json" ]; then
    echo "🧹 Removing package-lock.json..."
    rm -f package-lock.json
fi

echo ""

# Install dependencies
echo "📦 Installing dependencies with --legacy-peer-deps..."
npm install --legacy-peer-deps

echo ""
echo "✅ Setup complete!"
echo ""

# Verify ng command is available
if command -v ng &> /dev/null; then
    echo "✅ Angular CLI is ready to use"
else
    echo "⚠️  Angular CLI installed but not in PATH. You may need to:"
    echo "   - Restart your terminal, OR"
    echo "   - Run: source ~/.bashrc (or ~/.zshrc)"
fi

echo ""
echo "📝 Next steps:"
echo "   1. Make sure backend is running on http://localhost:8080/api"
echo "   2. Run: ./start.sh"
echo "      (This will automatically use the correct Node version and start the app)"
echo "   3. Access admin panel at: http://localhost:4200"
echo "   4. Login with: admin@shopizer.com / password"
echo ""
echo "💡 Note: The setup script sets Node v12.22.7 only for its own session."
echo "   Use './start.sh' to run the app with the correct Node version automatically."
echo "   Or manually run 'nvm use' before 'ng serve -o' in your terminal."
