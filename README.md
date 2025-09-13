# Actual Build - Full Stack Development Environment

A comprehensive full stack development environment designed for building modern web applications with ease. **Now with GitHub Codespaces support!**

## 🚀 Features

- **GitHub Codespaces Ready**: One-click development environment setup
- **Full Stack Ready**: Configured for both frontend and backend development
- **Modern Tech Stack**: Next.js 15, Express.js, TypeScript, Tailwind CSS
- **Environment Management**: Secure environment variable handling with .env support
- **Development Tools**: ESLint, Prettier, hot reload, and more
- **Scalable Architecture**: Organized project structure for growth
- **Developer Experience**: Optimized for productivity and ease of use

## 🏗️ Tech Stack

### Frontend
- **Next.js 15** with App Router
- **TypeScript** for type safety
- **Tailwind CSS** for styling
- **Turbopack** for fast development builds

### Backend
- **Express.js** with TypeScript
- **Node.js 20+** runtime
- **JWT** authentication ready
- **CORS** and security middleware

### Development
- **GitHub Codespaces** configuration
- **VS Code** extensions and settings
- **ESLint & Prettier** for code quality
- **Concurrently** for running multiple services

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

### For Local Development
- [Node.js](https://nodejs.org/) (v18 or higher)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- [Git](https://git-scm.com/)

### For Codespaces
- GitHub account
- Modern web browser
- (Optional) VS Code with GitHub Codespaces extension

## ⚡ Quick Start

### Option 1: GitHub Codespaces (Recommended)

1. **Open in Codespace**
   - Click the green "Code" button on GitHub
   - Select "Codespaces" tab
   - Click "Create codespace on main"
   - Wait for automatic setup (2-3 minutes)

2. **Start Development**
   ```bash
   npm run dev
   ```
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:3001

### Option 2: Local Development

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
- Modern JavaScript/TypeScript framework (Next.js 15)
- Component-based architecture with App Router
- TypeScript for type safety
- Tailwind CSS for responsive design
- Turbopack for fast development builds

### Backend
- RESTful API structure with Express.js
- TypeScript for type safety
- JWT authentication ready
- CORS and security middleware configured
- Environment-based configuration
- Structured error handling and logging

### Shared
- Common utilities and type definitions
- Validation schemas and helper functions
- Cross-platform constants and configurations
- Reusable business logic

## 📚 Documentation

- **[Codespace Setup](./docs/codespace-setup.md)** - GitHub Codespaces configuration and setup
- **[Frontend Setup](./docs/frontend.md)** - Next.js development guide
- **[Backend Setup](./docs/backend.md)** - Express.js API development guide
- **[API Documentation](./docs/api.md)** - API endpoints and usage
- **[Deployment Guide](./docs/deployment.md)** - Production deployment instructions
- **[Contributing Guidelines](./docs/contributing.md)** - How to contribute to the project

## 🎯 Current Status

✅ **Completed:**
- GitHub Codespaces configuration
- Next.js 15 frontend with TypeScript and Tailwind CSS
- Express.js backend with TypeScript
- Shared utilities and type definitions
- Development tooling (ESLint, Prettier)
- Hot reload and concurrent development
- Basic API endpoints and health checks
- Comprehensive documentation

🔄 **Ready for Development:**
- Database integration (PostgreSQL example configured)
- Authentication system (JWT ready)
- User management endpoints
- Frontend components and pages
- API route expansion
- Testing framework setup

## 🚀 Getting Started

1. **Create a Codespace** or clone locally
2. **Edit `.env`** with your configuration
3. **Run `npm run dev`** to start both servers
4. **Visit `http://localhost:3000`** to see the frontend
5. **Test API at `http://localhost:3001/api/health`**
6. **Start building your application!**

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