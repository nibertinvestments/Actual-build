# API Documentation

## Base URL

- **Development**: `http://localhost:3001`
- **Production**: `https://your-domain.com`

## Authentication

Most endpoints require authentication using JWT tokens:

```
Authorization: Bearer <token>
```

## Response Format

All API responses follow this structure:

```typescript
interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
}
```

### Success Response
```json
{
  "success": true,
  "data": { ... },
  "message": "Operation completed successfully"
}
```

### Error Response
```json
{
  "success": false,
  "error": "Error description"
}
```

## Endpoints

### Health Check

#### GET /api/health

Check if the API server is running.

**Response:**
```json
{
  "status": "OK",
  "message": "Actual Build API is running",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "version": "1.0.0"
}
```

### API Information

#### GET /api

Get basic API information and available endpoints.

**Response:**
```json
{
  "message": "Welcome to Actual Build API",
  "endpoints": [
    "GET /api/health - Health check",
    "GET /api - This endpoint"
  ]
}
```

## Example API Endpoints (to be implemented)

### Users

#### POST /api/auth/register
Register a new user.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123",
  "name": "John Doe"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "user-id",
    "email": "user@example.com",
    "name": "John Doe",
    "createdAt": "2024-01-01T00:00:00.000Z"
  },
  "message": "User registered successfully"
}
```

#### POST /api/auth/login
Authenticate a user.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "token": "jwt-token-here",
    "user": {
      "id": "user-id",
      "email": "user@example.com",
      "name": "John Doe"
    }
  },
  "message": "Login successful"
}
```

#### GET /api/users/profile
Get current user profile (requires authentication).

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "user-id",
    "email": "user@example.com",
    "name": "John Doe",
    "createdAt": "2024-01-01T00:00:00.000Z",
    "updatedAt": "2024-01-01T00:00:00.000Z"
  }
}
```

#### PUT /api/users/profile
Update user profile (requires authentication).

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "user-id",
    "email": "jane@example.com",
    "name": "Jane Doe",
    "updatedAt": "2024-01-01T00:00:00.000Z"
  },
  "message": "Profile updated successfully"
}
```

## Error Codes

| Status Code | Description |
|-------------|-------------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 409 | Conflict |
| 422 | Validation Error |
| 500 | Internal Server Error |

## Rate Limiting

- **Development**: No limits
- **Production**: 100 requests per 15 minutes per IP

When rate limited:
```json
{
  "success": false,
  "error": "Too many requests from this IP"
}
```

## Validation Errors

Validation errors return detailed information:

```json
{
  "success": false,
  "error": "Validation failed",
  "errors": [
    {
      "field": "email",
      "message": "Valid email is required"
    },
    {
      "field": "password",
      "message": "Password must be at least 8 characters"
    }
  ]
}
```

## Testing the API

### Using curl

```bash
# Health check
curl http://localhost:3001/api/health

# API info
curl http://localhost:3001/api

# Register user (example)
curl -X POST http://localhost:3001/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123","name":"Test User"}'

# Login (example)
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# Get profile with token (example)
curl http://localhost:3001/api/users/profile \
  -H "Authorization: Bearer your-jwt-token-here"
```

### Using Thunder Client (VS Code)

1. Install Thunder Client extension
2. Create new request
3. Set method and URL
4. Add headers if needed
5. Add request body for POST/PUT
6. Send request

### Using Postman

1. Import API collection (when available)
2. Set environment variables
3. Use collection runner for testing

## WebSocket Support (Future)

WebSocket endpoints for real-time features:

```javascript
// Connect to WebSocket
const ws = new WebSocket('ws://localhost:3001');

ws.on('open', () => {
  console.log('Connected to WebSocket');
});

ws.on('message', (data) => {
  console.log('Received:', data);
});
```

## API Versioning

API versions are handled through URL paths:

- **v1**: `/api/v1/...` (current)
- **v2**: `/api/v2/...` (future)

## CORS Configuration

Allowed origins:
- `http://localhost:3000` (development frontend)
- `https://your-domain.com` (production frontend)

Allowed methods: `GET`, `POST`, `PUT`, `DELETE`, `OPTIONS`

Allowed headers: `Content-Type`, `Authorization`

## Development Tools

### API Documentation Generator

Generate OpenAPI/Swagger documentation:

```bash
npm install swagger-jsdoc swagger-ui-express
```

### API Mocking

Use tools like JSON Server for frontend development:

```bash
npm install -g json-server
json-server --watch db.json --port 3002
```

### Load Testing

Test API performance:

```bash
npm install -g artillery
artillery quick --count 10 --num 10 http://localhost:3001/api/health
```

## Security Considerations

1. **Always validate input**
2. **Use HTTPS in production**
3. **Implement rate limiting**
4. **Sanitize output**
5. **Keep dependencies updated**
6. **Use environment variables for secrets**
7. **Implement proper error handling**
8. **Log security events**

## Monitoring

### Health Check Endpoint

Monitor API availability:
- **URL**: `/api/health`
- **Expected**: 200 status, valid JSON response
- **Frequency**: Every 30 seconds

### Metrics to Track

- Response times
- Error rates
- Request volume
- Authentication failures
- Database connection status

## Future Enhancements

- [ ] File upload endpoints
- [ ] Real-time WebSocket communication
- [ ] Advanced search and filtering
- [ ] Pagination support
- [ ] OpenAPI/Swagger documentation
- [ ] GraphQL endpoint
- [ ] Webhook support
- [ ] API key authentication
- [ ] Advanced caching strategies

## Resources

- [Express.js Routing](https://expressjs.com/en/guide/routing.html)
- [JWT.io](https://jwt.io/)
- [HTTP Status Codes](https://httpstatuses.com/)
- [REST API Design](https://restfulapi.net/)
- [OpenAPI Specification](https://swagger.io/specification/)