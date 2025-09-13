# Backend

This directory contains the backend API server for the Actual Build project.

## Getting Started

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up environment variables:
   ```bash
   cp ../.env.example ../.env
   # Edit .env with your configuration
   ```

4. Start the development server:
   ```bash
   npm run dev
   ```

## Structure

```
backend/
├── src/              # Source code
├── routes/           # API routes
├── middleware/       # Express middleware
├── models/           # Database models
├── controllers/      # Route controllers
├── utils/            # Utility functions
├── config/           # Configuration files
├── tests/            # Test files
├── package.json      # Dependencies and scripts
└── README.md         # This file
```

## Available Scripts

- `npm run dev` - Start development server with hot reload
- `npm run start` - Start production server
- `npm run build` - Build for production
- `npm run test` - Run tests
- `npm run lint` - Run linting

## Technologies

- Node.js with Express.js
- Database ORM/ODM
- Authentication middleware
- Input validation
- Error handling
- Logging
- Testing framework

## API Endpoints

The API will be available at `http://localhost:3001` by default.

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `POST /api/auth/logout` - User logout

### Example Routes
- `GET /api/health` - Health check
- `GET /api/users` - Get users
- `POST /api/users` - Create user

## Environment Variables

Key environment variables for the backend:
- `API_PORT` - Server port
- `DATABASE_URL` - Database connection string
- `JWT_SECRET` - JWT signing secret
- `NODE_ENV` - Environment (development/production)