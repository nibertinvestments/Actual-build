# Build and Deployment Scripts

This directory contains utility scripts for building, testing, and deploying the application.

## Contents

```
scripts/
├── build.sh          # Production build script
├── deploy.sh         # Deployment script
├── test.sh           # Test runner script
├── setup.sh          # Initial setup script
└── README.md         # This file
```

## Usage

Make scripts executable:
```bash
chmod +x scripts/*.sh
```

Run scripts from the project root:
```bash
./scripts/setup.sh     # Initial project setup
./scripts/build.sh     # Build for production
./scripts/test.sh      # Run all tests
./scripts/deploy.sh    # Deploy to production
```

## Scripts

### setup.sh
- Installs all dependencies
- Sets up environment files
- Initializes database (if needed)

### build.sh
- Builds frontend and backend for production
- Optimizes assets
- Prepares deployment artifacts

### test.sh
- Runs frontend tests
- Runs backend tests
- Generates coverage reports

### deploy.sh
- Builds the application
- Deploys to configured hosting platform
- Runs post-deployment checks