# Copilot Instructions for Actual Build

## Repository Overview

This is a full-stack development environment designed for building modern web applications. The repository follows a monorepo structure with separate frontend, backend, shared utilities, and build tooling.

### Architecture
```
Actual-build/
├── frontend/          # Frontend application (React/Vue/Angular)
├── backend/           # Backend API server (Node.js/Express)
├── shared/            # Shared utilities, types, and configurations
├── docs/              # Project documentation
├── scripts/           # Build and deployment scripts
├── .env.example       # Environment variables template
├── package.json       # Root dependencies and scripts
└── README.md          # Project documentation
```

## Development Workflow

### Initial Setup
Always ensure proper environment setup:
```bash
# 1. Install dependencies
npm install

# 2. Set up environment variables
cp .env.example .env
# Edit .env with appropriate values

# 3. Run setup script
./scripts/setup.sh
```

### Daily Development Workflow
1. **Start development servers**: `npm run dev`
2. **Run tests frequently**: `npm run test`
3. **Lint code before commits**: `npm run lint`
4. **Format code**: `npm run format`

### Branch Strategy
- Use feature branches: `feature/description`
- Use fix branches: `fix/issue-description`
- Use hotfix branches: `hotfix/critical-fix`
- Keep main branch stable and deployable

## Code Style and Conventions

### General Principles
- **SOLID principles**: Single responsibility, Open/closed, Liskov substitution, Interface segregation, Dependency inversion
- **DRY**: Don't repeat yourself - extract common functionality
- **KISS**: Keep it simple, stupid - prefer simple solutions
- **YAGNI**: You aren't gonna need it - don't over-engineer

### Naming Conventions
```javascript
// Variables and functions: camelCase
const userName = 'john';
function getUserData() {}

// Constants: UPPER_SNAKE_CASE
const API_BASE_URL = 'https://api.example.com';

// Classes: PascalCase
class UserService {}

// Files: kebab-case for components, camelCase for utilities
user-profile.component.js
userService.js

// Directories: kebab-case
user-management/
api-routes/
```

### Code Organization
- **Single Responsibility**: Each file/function should have one clear purpose
- **Barrel Exports**: Use index.js files to create clean import paths
- **Layer Separation**: Keep business logic separate from presentation logic
- **Configuration Management**: Centralize configuration in shared/config

### Import/Export Standards
```javascript
// Prefer named exports
export const userService = {};
export class UserValidator {}

// Use default exports sparingly, only for main component/class
export default UserComponent;

// Group imports: external, internal, relative
import React from 'react';
import axios from 'axios';

import { UserService } from '../services';
import { validateUser } from '../shared/validators';

import './Component.css';
```

## Frontend Development Guidelines

### Component Structure
```javascript
// Functional components with hooks
import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';

const UserProfile = ({ userId, onUpdate }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Effect logic
  }, [userId]);

  return (
    <div className="user-profile">
      {/* Component JSX */}
    </div>
  );
};

UserProfile.propTypes = {
  userId: PropTypes.string.isRequired,
  onUpdate: PropTypes.func
};

export default UserProfile;
```

### State Management
- Use React Context for global state
- Use local state for component-specific data
- Consider Redux for complex state management
- Keep state normalized and minimal

### Styling Guidelines
- Use CSS modules or styled-components
- Follow BEM methodology for CSS classes
- Use CSS custom properties for theming
- Ensure responsive design with mobile-first approach

## Backend Development Guidelines

### API Design
- Follow RESTful principles
- Use consistent HTTP status codes
- Implement proper error handling
- Use middleware for cross-cutting concerns

```javascript
// Route structure
app.get('/api/users', getAllUsers);
app.get('/api/users/:id', getUserById);
app.post('/api/users', createUser);
app.put('/api/users/:id', updateUser);
app.delete('/api/users/:id', deleteUser);

// Response format
{
  "success": true,
  "data": {},
  "message": "Operation successful",
  "timestamp": "2023-01-01T00:00:00Z"
}
```

### Error Handling
```javascript
// Custom error classes
class ValidationError extends Error {
  constructor(message) {
    super(message);
    this.name = 'ValidationError';
    this.statusCode = 400;
  }
}

// Global error handler middleware
const errorHandler = (err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  res.status(statusCode).json({
    success: false,
    message: err.message,
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
  });
};
```

### Database Guidelines
- Use migrations for schema changes
- Implement proper indexing
- Use transactions for related operations
- Validate data at both application and database levels

## Testing Guidelines

### Testing Strategy
- **Unit Tests**: Test individual functions/components
- **Integration Tests**: Test component interactions
- **E2E Tests**: Test complete user workflows
- **API Tests**: Test endpoint functionality

### Test Structure
```javascript
// Jest test example
describe('UserService', () => {
  describe('getUserById', () => {
    beforeEach(() => {
      // Setup
    });

    it('should return user when valid ID provided', async () => {
      // Arrange
      const userId = '123';
      const expectedUser = { id: '123', name: 'John' };

      // Act
      const result = await UserService.getUserById(userId);

      // Assert
      expect(result).toEqual(expectedUser);
    });

    it('should throw error when invalid ID provided', async () => {
      // Arrange
      const invalidId = 'invalid';

      // Act & Assert
      await expect(UserService.getUserById(invalidId))
        .rejects.toThrow('User not found');
    });
  });
});
```

### Testing Best Practices
- Write tests before or alongside code (TDD/BDD)
- Keep tests isolated and independent
- Use descriptive test names
- Test edge cases and error conditions
- Maintain test coverage above 80%

## Security Best Practices

### Authentication & Authorization
- Use JWT tokens with proper expiration
- Implement refresh token rotation
- Use HTTPS in production
- Validate and sanitize all inputs

### Data Protection
```javascript
// Input validation
const { body, validationResult } = require('express-validator');

app.post('/api/users',
  [
    body('email').isEmail().normalizeEmail(),
    body('password').isLength({ min: 8 }).isStrongPassword()
  ],
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    // Process request
  }
);
```

### Environment Security
- Never commit secrets to version control
- Use environment variables for sensitive data
- Implement rate limiting
- Use security headers (helmet.js)
- Regular dependency updates

## Performance Considerations

### Frontend Performance
- Implement code splitting and lazy loading
- Optimize bundle size and eliminate dead code
- Use React.memo and useMemo for expensive operations
- Implement proper caching strategies

### Backend Performance
- Use database connection pooling
- Implement caching (Redis/Memcached)
- Use compression middleware
- Monitor and profile database queries

### Monitoring
- Implement logging (Winston/Bunyan)
- Use APM tools (New Relic, DataDog)
- Monitor key metrics (response time, error rates)
- Set up alerts for critical issues

## Documentation Standards

### Code Documentation
```javascript
/**
 * Retrieves user data by ID with optional includes
 * @param {string} userId - The unique user identifier
 * @param {Object} options - Query options
 * @param {string[]} options.include - Related data to include
 * @returns {Promise<Object>} User object with requested includes
 * @throws {ValidationError} When userId is invalid
 * @throws {NotFoundError} When user doesn't exist
 */
async function getUserById(userId, options = {}) {
  // Implementation
}
```

### API Documentation
- Use OpenAPI/Swagger for API documentation
- Include request/response examples
- Document authentication requirements
- Maintain up-to-date documentation

### README Files
- Keep README files current in each directory
- Include setup instructions
- Document available scripts and commands
- Provide troubleshooting information

## Common Patterns

### Error Handling Pattern
```javascript
// Use Result pattern for error handling
class Result {
  constructor(isSuccess, error, value) {
    this.isSuccess = isSuccess;
    this.error = error;
    this.value = value;
  }

  static success(value) {
    return new Result(true, null, value);
  }

  static failure(error) {
    return new Result(false, error, null);
  }
}
```

### Repository Pattern
```javascript
class UserRepository {
  async findById(id) {
    try {
      const user = await db.users.findByPk(id);
      return Result.success(user);
    } catch (error) {
      return Result.failure(error);
    }
  }
}
```

### Service Layer Pattern
```javascript
class UserService {
  constructor(userRepository) {
    this.userRepository = userRepository;
  }

  async getUserProfile(userId) {
    const result = await this.userRepository.findById(userId);
    if (!result.isSuccess) {
      throw new Error('User not found');
    }
    return this.formatUserProfile(result.value);
  }
}
```

## Anti-Patterns to Avoid

### Code Anti-Patterns
- **God Objects**: Avoid classes that do too much
- **Spaghetti Code**: Keep code organized and modular
- **Magic Numbers**: Use named constants
- **Deep Nesting**: Use early returns and guard clauses

### Architecture Anti-Patterns
- **Tight Coupling**: Use dependency injection
- **Circular Dependencies**: Restructure module relationships
- **Shared Mutable State**: Use immutable patterns
- **Premature Optimization**: Profile before optimizing

## Environment-Specific Guidelines

### Development Environment
- Use detailed logging and debugging tools
- Enable hot reloading for faster development
- Use development-specific database seeds
- Disable caching for real-time updates

### Production Environment
- Enable compression and minification
- Use production database configurations
- Implement proper logging and monitoring
- Use PM2 or similar for process management

## Troubleshooting Guide

### Common Issues
1. **Port conflicts**: Check for running processes on required ports
2. **Environment variables**: Verify .env file exists and has correct values
3. **Database connections**: Ensure database is running and accessible
4. **Dependency issues**: Clear node_modules and reinstall

### Debugging Strategies
- Use debugger statements and breakpoints
- Check browser network tab for API issues
- Review server logs for backend errors
- Use React DevTools for frontend debugging

### Performance Issues
- Profile database queries for slow operations
- Check bundle size for frontend performance
- Monitor memory usage for memory leaks
- Use lighthouse for web performance audits

## CI/CD Best Practices

### Automated Testing
- Run tests on every commit
- Block merges if tests fail
- Include different test types (unit, integration, e2e)
- Generate and track coverage reports

### Deployment Pipeline
1. **Build**: Compile and bundle applications
2. **Test**: Run automated test suites
3. **Security Scan**: Check for vulnerabilities
4. **Deploy**: Deploy to staging/production
5. **Monitor**: Check deployment health

### Quality Gates
- Code coverage thresholds
- Security vulnerability checks
- Performance regression tests
- Code quality metrics (SonarQube)

## Collaboration Guidelines

### Code Reviews
- Review for logic, security, and performance
- Check adherence to coding standards
- Ensure adequate test coverage
- Provide constructive feedback

### Git Practices
- Write clear, descriptive commit messages
- Keep commits atomic and focused
- Use conventional commit format when possible
- Rebase feature branches before merging

### Communication
- Document architectural decisions
- Share knowledge through code comments
- Use pull request descriptions effectively
- Maintain team coding standards

## Tools and Extensions

### Recommended VS Code Extensions
- ESLint
- Prettier
- Auto Rename Tag
- GitLens
- Thunder Client (API testing)
- Error Lens

### Development Tools
- **Linting**: ESLint with Airbnb config
- **Formatting**: Prettier
- **Testing**: Jest, React Testing Library
- **API Testing**: Postman, Insomnia
- **Database**: DB Browser, pgAdmin

Remember: These guidelines serve as a foundation. Adapt them based on specific project requirements and team preferences while maintaining consistency and quality standards.