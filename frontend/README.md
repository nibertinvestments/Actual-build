# Frontend

This directory contains the frontend application for the Actual Build project.

## Getting Started

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```

## Structure

```
frontend/
├── src/              # Source code
├── public/           # Static assets
├── package.json      # Dependencies and scripts
└── README.md         # This file
```

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run test` - Run tests
- `npm run lint` - Run linting

## Technologies

- Modern JavaScript/TypeScript framework
- Component-based architecture
- CSS-in-JS or CSS modules
- Testing framework
- Build tools and bundler

## Configuration

The frontend reads environment variables from the root `.env` file.
Key variables:
- `FRONTEND_PORT` - Development server port
- `API_HOST` - Backend API host
- `API_PORT` - Backend API port