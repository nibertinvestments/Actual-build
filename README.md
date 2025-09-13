# Actual Build - Full Stack Development Environment

A comprehensive full stack development environment designed for building modern web applications with ease.

## 🚀 Features

- **Full Stack Ready**: Configured for both frontend and backend development
- **Environment Management**: Secure environment variable handling with .env support
- **Modern Tooling**: Latest development tools and best practices
- **Scalable Architecture**: Organized project structure for growth
- **Developer Experience**: Optimized for productivity and ease of use

## 📁 Project Structure

```
Actual-build/
├── frontend/          # Frontend application
├── backend/           # Backend API server
├── shared/            # Shared utilities and types
├── docs/              # Project documentation
├── scripts/           # Build and deployment scripts
├── .env.example       # Environment variables template
├── .gitignore         # Git ignore rules
├── package.json       # Project dependencies and scripts
└── README.md          # This file
```

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:

- [Node.js](https://nodejs.org/) (v18 or higher)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- [Git](https://git-scm.com/)

## ⚡ Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/nibertinvestments/Actual-build.git
   cd Actual-build
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. **Start development servers**
   ```bash
   npm run dev
   ```

## 🔧 Development

### Environment Variables

Create a `.env` file in the root directory based on `.env.example`:

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
# Add your service configurations here
```

### Available Scripts

- `npm run dev` - Start both frontend and backend in development mode
- `npm run dev:frontend` - Start only the frontend development server
- `npm run dev:backend` - Start only the backend development server
- `npm run build` - Build the entire application for production
- `npm run build:frontend` - Build only the frontend
- `npm run build:backend` - Build only the backend
- `npm run test` - Run all tests
- `npm run test:frontend` - Run frontend tests
- `npm run test:backend` - Run backend tests
- `npm run lint` - Run linting on all code
- `npm run format` - Format code using Prettier

## 🏗️ Architecture

### Frontend
- Modern JavaScript/TypeScript framework ready
- Component-based architecture
- State management setup
- Responsive design utilities

### Backend
- RESTful API structure
- Database integration ready
- Authentication middleware
- Error handling and logging

### Shared
- Common utilities
- Type definitions
- Validation schemas
- Constants and configurations

## 📚 Documentation

- [Frontend Setup](./docs/frontend.md)
- [Backend Setup](./docs/backend.md)
- [Deployment Guide](./docs/deployment.md)
- [API Documentation](./docs/api.md)
- [Contributing Guidelines](./docs/contributing.md)

## 🚀 Deployment

### Production Build

```bash
npm run build
```

### Environment Setup

1. Set up production environment variables
2. Configure your hosting platform
3. Deploy using your preferred method

### Supported Platforms

- Vercel
- Netlify
- Heroku
- AWS
- DigitalOcean
- Custom VPS

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues or have questions:

1. Check the [documentation](./docs/)
2. Search existing [issues](https://github.com/nibertinvestments/Actual-build/issues)
3. Create a new issue if needed

## 🙏 Acknowledgments

- Built with modern development best practices
- Inspired by the open source community
- Thanks to all contributors

---

**Happy Coding! 🎉**