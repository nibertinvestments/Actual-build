# Backend Development Guide

## Overview

The backend is built with Express.js, TypeScript, and Node.js, providing a robust API server with modern development practices.

## Technology Stack

- **Runtime**: Node.js 20+
- **Framework**: Express.js
- **Language**: TypeScript
- **Development**: Nodemon with ts-node
- **Security**: Helmet, CORS
- **Logging**: Morgan
- **Environment**: dotenv

## Project Structure

```
backend/
├── src/
│   ├── index.ts          # Main server file
│   ├── routes/           # API route handlers
│   ├── middleware/       # Custom middleware
│   ├── controllers/      # Business logic
│   ├── models/           # Data models
│   ├── services/         # External services
│   ├── utils/            # Utility functions
│   └── types/            # TypeScript types
├── dist/                 # Compiled JavaScript (generated)
├── package.json          # Dependencies and scripts
├── tsconfig.json         # TypeScript configuration
└── .env                  # Environment variables
```

## Development Commands

```bash
cd backend

# Development
npm run dev          # Start development server with nodemon
npm run start        # Start production server
npm run build        # Compile TypeScript to JavaScript
npm run lint         # Run ESLint
npm run test         # Run tests (when configured)

# From root directory
npm run dev:backend  # Start backend only
```

## Current API Endpoints

### Health Check
```
GET /api/health
```
Response:
```json
{
  "status": "OK",
  "message": "Actual Build API is running",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "version": "1.0.0"
}
```

### API Info
```
GET /api
```
Response:
```json
{
  "message": "Welcome to Actual Build API",
  "endpoints": [
    "GET /api/health - Health check",
    "GET /api - This endpoint"
  ]
}
```

## Configuration

### Environment Variables (.env)
```env
# Server Configuration
API_PORT=3001
API_HOST=localhost
NODE_ENV=development

# CORS Configuration
CORS_ORIGIN=http://localhost:3000

# Database (example)
DATABASE_URL=postgresql://username:password@localhost:5432/actual_build_db

# Security
JWT_SECRET=your_super_secret_jwt_key_here
JWT_EXPIRES_IN=7d
ENCRYPTION_KEY=your_32_character_encryption_key

# Logging
LOG_LEVEL=info
```

### TypeScript Configuration (tsconfig.json)
```json
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
```

## Development Workflow

### 1. Adding New Routes
```typescript
// src/routes/users.ts
import express from 'express';
import { getUsers, createUser } from '../controllers/userController';

const router = express.Router();

router.get('/users', getUsers);
router.post('/users', createUser);

export default router;
```

```typescript
// src/index.ts - Register routes
import userRoutes from './routes/users';

app.use('/api', userRoutes);
```

### 2. Creating Controllers
```typescript
// src/controllers/userController.ts
import { Request, Response } from 'express';
import { ApiResponse, User } from '../../shared/src/types';

export const getUsers = async (req: Request, res: Response) => {
  try {
    // Business logic here
    const users: User[] = []; // Fetch from database
    
    const response: ApiResponse<User[]> = {
      success: true,
      data: users,
      message: 'Users retrieved successfully'
    };
    
    res.json(response);
  } catch (error) {
    res.status(500).json({
      success: false,
      error: 'Failed to retrieve users'
    });
  }
};

export const createUser = async (req: Request, res: Response) => {
  try {
    const userData = req.body;
    // Validation and creation logic
    
    const response: ApiResponse<User> = {
      success: true,
      data: userData,
      message: 'User created successfully'
    };
    
    res.status(201).json(response);
  } catch (error) {
    res.status(400).json({
      success: false,
      error: 'Failed to create user'
    });
  }
};
```

### 3. Adding Middleware
```typescript
// src/middleware/auth.ts
import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

export const authenticateToken = (req: Request, res: Response, next: NextFunction) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'Access token required' });
  }

  jwt.verify(token, process.env.JWT_SECRET!, (err, user) => {
    if (err) {
      return res.status(403).json({ error: 'Invalid token' });
    }
    req.user = user;
    next();
  });
};
```

### 4. Database Integration
```typescript
// src/services/database.ts
import { Pool } from 'pg';

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

export const query = (text: string, params?: any[]) => {
  return pool.query(text, params);
};

export default pool;
```

### 5. Input Validation
```typescript
// src/middleware/validation.ts
import { Request, Response, NextFunction } from 'express';
import { validateEmail } from '../../shared/src/utils';

export const validateUserInput = (req: Request, res: Response, next: NextFunction) => {
  const { email, name } = req.body;

  if (!email || !validateEmail(email)) {
    return res.status(400).json({ error: 'Valid email is required' });
  }

  if (!name || name.trim().length < 2) {
    return res.status(400).json({ error: 'Name must be at least 2 characters' });
  }

  next();
};
```

## Security Best Practices

### 1. Environment Variables
- Never commit `.env` files
- Use strong secrets for JWT
- Rotate keys regularly
- Use different secrets for different environments

### 2. Input Validation
```typescript
// Always validate and sanitize input
import { body, validationResult } from 'express-validator';

export const validateUserRegistration = [
  body('email').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }).matches(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/),
  body('name').trim().isLength({ min: 2, max: 50 }),
  
  (req: Request, res: Response, next: NextFunction) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    next();
  }
];
```

### 3. Rate Limiting
```typescript
import rateLimit from 'express-rate-limit';

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP'
});

app.use('/api', limiter);
```

### 4. CORS Configuration
```typescript
app.use(cors({
  origin: process.env.CORS_ORIGIN?.split(',') || 'http://localhost:3000',
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
```

## Error Handling

### 1. Global Error Handler
```typescript
// src/middleware/errorHandler.ts
import { Request, Response, NextFunction } from 'express';

export const errorHandler = (
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.error(err.stack);

  // Don't leak error details in production
  const isDevelopment = process.env.NODE_ENV === 'development';

  res.status(500).json({
    success: false,
    error: isDevelopment ? err.message : 'Internal server error',
    ...(isDevelopment && { stack: err.stack })
  });
};
```

### 2. Async Error Wrapper
```typescript
// src/utils/asyncHandler.ts
import { Request, Response, NextFunction } from 'express';

export const asyncHandler = (fn: Function) => (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  Promise.resolve(fn(req, res, next)).catch(next);
};

// Usage
export const getUser = asyncHandler(async (req: Request, res: Response) => {
  const user = await userService.getById(req.params.id);
  res.json({ success: true, data: user });
});
```

## Testing

### 1. Unit Tests
```typescript
// src/controllers/__tests__/userController.test.ts
import { Request, Response } from 'express';
import { getUsers } from '../userController';

describe('User Controller', () => {
  test('should return users list', async () => {
    const req = {} as Request;
    const res = {
      json: jest.fn(),
      status: jest.fn().mockReturnThis()
    } as unknown as Response;

    await getUsers(req, res);

    expect(res.json).toHaveBeenCalledWith({
      success: true,
      data: expect.any(Array)
    });
  });
});
```

### 2. Integration Tests
```typescript
// src/__tests__/api.test.ts
import request from 'supertest';
import app from '../index';

describe('API Endpoints', () => {
  test('GET /api/health', async () => {
    const response = await request(app)
      .get('/api/health')
      .expect(200);

    expect(response.body).toEqual({
      status: 'OK',
      message: 'Actual Build API is running',
      timestamp: expect.any(String),
      version: '1.0.0'
    });
  });
});
```

## Logging

```typescript
// src/utils/logger.ts
import winston from 'winston';

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'logs/error.log', level: 'error' }),
    new winston.transports.File({ filename: 'logs/combined.log' })
  ]
});

if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.simple()
  }));
}

export default logger;
```

## Deployment

### 1. Build for Production
```bash
npm run build
npm start
```

### 2. Docker Support
```dockerfile
# Dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npm run build

EXPOSE 3001

CMD ["npm", "start"]
```

## Troubleshooting

### Common Issues

1. **Port already in use**
   ```bash
   npx kill-port 3001
   npm run dev
   ```

2. **TypeScript compilation errors**
   ```bash
   npm run build
   # Fix errors shown in output
   ```

3. **Environment variables not loading**
   - Check `.env` file exists
   - Verify variable names
   - Restart the server

4. **CORS errors**
   - Check `CORS_ORIGIN` in `.env`
   - Ensure frontend URL is allowed
   - Verify request headers

### Performance Issues

1. **Slow API responses**
   - Add database indexes
   - Implement caching
   - Use connection pooling
   - Profile slow queries

2. **Memory leaks**
   - Monitor memory usage
   - Close database connections
   - Remove event listeners
   - Use memory profiling tools

## Resources

- [Express.js Documentation](https://expressjs.com/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Node.js Documentation](https://nodejs.org/docs/)
- [JWT.io](https://jwt.io/)

## Integration with Frontend

The backend serves API endpoints that the frontend consumes. See [API Documentation](./api.md) for detailed endpoint specifications.