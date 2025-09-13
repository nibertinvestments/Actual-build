# Codespace Setup Guide

## Getting Started with GitHub Codespaces

This repository is configured with GitHub Codespaces for immediate development. Follow these steps to get started:

### 1. Creating a Codespace

1. **From GitHub:**
   - Go to the repository: https://github.com/nibertinvestments/Actual-build
   - Click the green "Code" button
   - Select "Codespaces" tab
   - Click "Create codespace on main"

2. **From VS Code:**
   - Install the GitHub Codespaces extension
   - Use Command Palette (Ctrl/Cmd + Shift + P)
   - Type "Codespaces: Create New Codespace"
   - Select the repository

### 2. Automatic Setup

The codespace will automatically:
- Install Node.js 20.x
- Install all dependencies
- Set up the development environment
- Configure VS Code extensions
- Create environment files

### 3. Manual Setup (if needed)

If you need to set up manually or run setup again:

```bash
# Run the setup script
bash .devcontainer/setup.sh

# Or run individual steps
npm install
cp .env.example .env
cd frontend && npm install
cd ../backend && npm install
```

### 4. Development Commands

Start the development environment:
```bash
npm run dev          # Start both frontend and backend
npm run dev:frontend # Start only frontend (port 3000)
npm run dev:backend  # Start only backend (port 3001)
```

Build applications:
```bash
npm run build         # Build both applications
npm run build:frontend # Build frontend only
npm run build:backend  # Build backend only
```

Run tests:
```bash
npm run test           # Run all tests
npm run test:frontend  # Run frontend tests
npm run test:backend   # Run backend tests
```

Lint and format code:
```bash
npm run lint           # Lint all code
npm run format         # Format all code with Prettier
```

### 5. Environment Configuration

Edit `.env` file with your configuration:

```env
# Database
DATABASE_URL=your_database_url

# API Configuration
API_PORT=3001
API_HOST=localhost

# Frontend Configuration
FRONTEND_PORT=3000

# Security
JWT_SECRET=your_jwt_secret
ENCRYPTION_KEY=your_encryption_key

# External Services
# Add your API keys and service configurations
```

### 6. Port Forwarding

The codespace automatically forwards these ports:
- **3000**: Frontend (Next.js)
- **3001**: Backend API (Express)
- **5432**: PostgreSQL (if using database)

### 7. VS Code Extensions

Pre-installed extensions:
- TypeScript support
- ESLint and Prettier
- Tailwind CSS IntelliSense
- Path IntelliSense
- Thunder Client (API testing)
- Auto Rename Tag
- Code Spell Checker

### 8. Troubleshooting

**Port already in use:**
```bash
# Kill processes on ports
npx kill-port 3000 3001
```

**Restart development servers:**
```bash
# Stop current process (Ctrl+C) then restart
npm run dev
```

**Reset environment:**
```bash
# Clean install
npm run clean
npm install
```

**Update dependencies:**
```bash
# Update all dependencies
npm update
cd frontend && npm update
cd ../backend && npm update
```

### 9. Authentication Setup

For external services, add your credentials to `.env`:

```env
# GitHub (if using GitHub API)
GITHUB_TOKEN=your_github_token

# Google OAuth (if using Google auth)
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret

# Stripe (if using payments)
STRIPE_PUBLIC_KEY=pk_test_your_stripe_public_key
STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key

# Database (if using external database)
DATABASE_URL=postgresql://username:password@host:port/database
```

### 10. Next Steps

1. **Customize the frontend** in `frontend/src/`
2. **Build API endpoints** in `backend/src/`
3. **Add shared utilities** in `shared/src/`
4. **Configure database** connections
5. **Set up authentication** middleware
6. **Deploy to production** when ready

### 11. Quick Links

- [Frontend Documentation](./frontend.md)
- [Backend Documentation](./backend.md)
- [API Documentation](./api.md)
- [Deployment Guide](./deployment.md)
- [Contributing Guidelines](./contributing.md)

### 12. Support

If you encounter issues:
1. Check the [troubleshooting section](#8-troubleshooting)
2. Review the [documentation](../README.md)
3. Create an issue in the repository