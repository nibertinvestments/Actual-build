#!/bin/bash

# Actual Build - Codespace Setup Script
# This script sets up the development environment in GitHub Codespaces

set -e

echo "🚀 Setting up Actual Build Codespace..."

# Update package manager and install system dependencies
echo "📦 Installing system dependencies..."
sudo apt-get update
sudo apt-get install -y postgresql-client git curl

# Set up environment file
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "✅ Created .env file (edit with your actual credentials)"
else
    echo "✅ .env file already exists"
fi

# Install root dependencies
echo "📦 Installing root dependencies..."
npm install

# Set up frontend
echo "🎨 Setting up frontend environment..."
cd frontend
if [ ! -d "node_modules" ]; then
    echo "Installing Next.js frontend..."
    npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --yes
    
    # Update package.json scripts
    npm pkg set scripts.dev="next dev"
    npm pkg set scripts.build="next build"
    npm pkg set scripts.start="next start"
    npm pkg set scripts.lint="next lint"
    npm pkg set scripts.test="jest"
    
    # Install additional development dependencies
    npm install --save-dev jest @testing-library/react @testing-library/jest-dom
fi
cd ..

# Set up backend
echo "🔧 Setting up backend environment..."
cd backend
if [ ! -d "node_modules" ]; then
    echo "Installing Express backend..."
    npm install express cors helmet morgan dotenv bcryptjs jsonwebtoken
    npm install --save-dev nodemon @types/node @types/express @types/cors @types/bcryptjs @types/jsonwebtoken typescript ts-node eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier
    
    # Update package.json scripts
    npm pkg set scripts.dev="nodemon src/index.ts"
    npm pkg set scripts.start="node dist/index.js"
    npm pkg set scripts.build="tsc"
    npm pkg set scripts.test="jest"
    npm pkg set scripts.lint="eslint src --ext .ts,.js"
    npm pkg set main="dist/index.js"
    
    # Create TypeScript configuration
    echo "Creating TypeScript configuration..."
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts"]
}
EOF

    # Create basic Express server
    mkdir -p src
    cat > src/index.ts << 'EOF'
import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.API_PORT || 3001;

// Middleware
app.use(helmet());
app.use(cors({
  origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
  credentials: true
}));
app.use(morgan('combined'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    message: 'Actual Build API is running',
    timestamp: new Date().toISOString(),
    version: '1.0.0'
  });
});

app.get('/api', (req, res) => {
  res.json({ 
    message: 'Welcome to Actual Build API',
    endpoints: [
      'GET /api/health - Health check',
      'GET /api - This endpoint'
    ]
  });
});

// Error handling middleware
app.use((err: any, req: express.Request, res: express.Response, next: express.NextFunction) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'Something went wrong!',
    message: process.env.NODE_ENV === 'development' ? err.message : 'Internal server error'
  });
});

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📡 API available at http://localhost:${PORT}/api`);
  console.log(`🏥 Health check at http://localhost:${PORT}/api/health`);
});
EOF
fi
cd ..

# Set up shared utilities
echo "🔧 Setting up shared utilities..."
cd shared
if [ ! -f package.json ]; then
    npm init -y
    npm pkg set name="actual-build-shared"
    npm pkg set description="Shared utilities and types for Actual Build"
    npm pkg set main="dist/index.js"
    npm pkg set types="dist/index.d.ts"
    
    npm install --save-dev typescript @types/node
    
    # Create TypeScript configuration
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts"]
}
EOF

    # Create basic shared types
    mkdir -p src/types
    cat > src/types/index.ts << 'EOF'
// Shared type definitions for Actual Build

export interface User {
  id: string;
  email: string;
  name: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
}

export interface PaginatedResponse<T = any> extends ApiResponse<T[]> {
  pagination: {
    page: number;
    limit: number;
    total: number;
    pages: number;
  };
}
EOF

    cat > src/index.ts << 'EOF'
// Shared utilities and types
export * from './types';
export * from './utils';
EOF

    mkdir -p src/utils
    cat > src/utils/index.ts << 'EOF'
// Shared utility functions

export const formatDate = (date: Date): string => {
  return date.toISOString().split('T')[0];
};

export const validateEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

export const generateId = (): string => {
  return Math.random().toString(36).substr(2, 9);
};
EOF

    npm pkg set scripts.build="tsc"
    npm pkg set scripts.dev="tsc --watch"
fi
cd ..

# Create global development configuration files
echo "⚙️ Creating development configuration..."

# Prettier configuration
if [ ! -f .prettierrc ]; then
    cat > .prettierrc << 'EOF'
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false
}
EOF
fi

# ESLint configuration
if [ ! -f .eslintrc.js ]; then
    cat > .eslintrc.js << 'EOF'
module.exports = {
  root: true,
  env: {
    node: true,
    es2022: true,
  },
  extends: [
    'eslint:recommended',
    '@typescript-eslint/recommended',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: 'module',
  },
  plugins: ['@typescript-eslint'],
  rules: {
    '@typescript-eslint/no-unused-vars': 'error',
    '@typescript-eslint/no-explicit-any': 'warn',
  },
  ignorePatterns: ['dist/', 'node_modules/', '*.js'],
};
EOF
fi

echo "✅ Codespace setup complete!"
echo ""
echo "🎉 Your development environment is ready!"
echo ""
echo "📝 Next steps:"
echo "1. Edit .env file with your actual configuration"
echo "2. Run 'npm run dev' to start both frontend and backend"
echo "3. Frontend will be available at http://localhost:3000"
echo "4. Backend API will be available at http://localhost:3001"
echo ""
echo "🔧 Available commands:"
echo "  npm run dev          - Start both frontend and backend"
echo "  npm run dev:frontend - Start only frontend"
echo "  npm run dev:backend  - Start only backend"
echo "  npm run build        - Build both applications"
echo "  npm run test         - Run all tests"
echo "  npm run lint         - Lint all code"
echo ""
echo "📚 Check the docs/ directory for detailed guides"