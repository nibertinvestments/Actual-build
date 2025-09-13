#!/bin/bash

# Actual Build - Setup Script
# This script sets up the development environment

set -e

echo "🚀 Setting up Actual Build development environment..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ and try again."
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version 18+ is required. Current version: $(node -v)"
    exit 1
fi

echo "✅ Node.js version: $(node -v)"

# Install root dependencies
echo "📦 Installing root dependencies..."
npm install

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  Please edit .env file with your configuration before starting development"
else
    echo "✅ .env file already exists"
fi

# Create basic package.json files for frontend and backend if they don't exist
if [ ! -f frontend/package.json ]; then
    echo "📦 Creating frontend package.json..."
    mkdir -p frontend
    cat > frontend/package.json << 'EOF'
{
  "name": "actual-build-frontend",
  "version": "1.0.0",
  "description": "Frontend for Actual Build",
  "main": "index.js",
  "scripts": {
    "dev": "echo 'Frontend development server not configured yet'",
    "build": "echo 'Frontend build not configured yet'",
    "test": "echo 'Frontend tests not configured yet'",
    "lint": "echo 'Frontend linting not configured yet'"
  },
  "keywords": ["frontend", "web"],
  "author": "Nibert Investments",
  "license": "MIT"
}
EOF
fi

if [ ! -f backend/package.json ]; then
    echo "📦 Creating backend package.json..."
    mkdir -p backend
    cat > backend/package.json << 'EOF'
{
  "name": "actual-build-backend",
  "version": "1.0.0",
  "description": "Backend API for Actual Build",
  "main": "index.js",
  "scripts": {
    "dev": "echo 'Backend development server not configured yet'",
    "start": "echo 'Backend production server not configured yet'",
    "build": "echo 'Backend build not configured yet'",
    "test": "echo 'Backend tests not configured yet'",
    "lint": "echo 'Backend linting not configured yet'"
  },
  "keywords": ["backend", "api", "nodejs"],
  "author": "Nibert Investments",
  "license": "MIT"
}
EOF
fi

echo "✅ Setup complete!"
echo ""
echo "🎉 Next steps:"
echo "1. Edit .env file with your configuration"
echo "2. Set up your frontend framework in the frontend/ directory"
echo "3. Set up your backend server in the backend/ directory"
echo "4. Run 'npm run dev' to start development servers"
echo ""
echo "📚 Check the README.md for detailed instructions"