# Frontend Development Guide

## Overview

The frontend is built with Next.js 15, TypeScript, and Tailwind CSS, providing a modern React-based development experience.

## Technology Stack

- **Framework**: Next.js 15 with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Bundler**: Turbopack (for development)
- **Linting**: ESLint with Next.js config
- **Formatting**: Prettier

## Project Structure

```
frontend/
├── src/
│   ├── app/              # App router pages and layouts
│   │   ├── layout.tsx    # Root layout
│   │   ├── page.tsx      # Homepage
│   │   └── globals.css   # Global styles
│   ├── components/       # Reusable components
│   ├── lib/              # Utility functions
│   └── types/            # TypeScript types
├── public/               # Static assets
├── package.json          # Dependencies and scripts
├── next.config.js        # Next.js configuration
├── tailwind.config.js    # Tailwind CSS configuration
└── tsconfig.json         # TypeScript configuration
```

## Development Commands

```bash
cd frontend

# Development
npm run dev          # Start development server
npm run build        # Build for production
npm run start        # Start production server
npm run lint         # Run ESLint
npm run test         # Run tests (when configured)

# From root directory
npm run dev:frontend # Start frontend only
```

## Key Features

### 1. App Router (Next.js 15)
- Modern routing with the `app/` directory
- Server Components by default
- Layouts and nested routing
- Built-in loading and error states

### 2. TypeScript Integration
- Strict type checking
- IntelliSense support
- Type-safe API calls
- Shared types from `../shared` directory

### 3. Tailwind CSS
- Utility-first CSS framework
- Dark mode support
- Responsive design utilities
- Custom component styling

### 4. Performance Optimizations
- Turbopack for fast development builds
- Automatic code splitting
- Image optimization
- Font optimization

## Configuration Files

### next.config.js
```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    turbo: {
      rules: {
        // Custom Turbopack rules if needed
      }
    }
  }
}

module.exports = nextConfig
```

### tailwind.config.js
```javascript
import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      // Custom theme extensions
    },
  },
  plugins: [],
};

export default config;
```

## Development Workflow

### 1. Creating Components
```typescript
// src/components/Button.tsx
interface ButtonProps {
  children: React.ReactNode;
  onClick?: () => void;
  variant?: 'primary' | 'secondary';
}

export default function Button({ children, onClick, variant = 'primary' }: ButtonProps) {
  return (
    <button
      onClick={onClick}
      className={`px-4 py-2 rounded ${
        variant === 'primary' 
          ? 'bg-blue-500 text-white' 
          : 'bg-gray-200 text-gray-800'
      }`}
    >
      {children}
    </button>
  );
}
```

### 2. Creating Pages
```typescript
// src/app/about/page.tsx
export default function About() {
  return (
    <div className="container mx-auto px-4">
      <h1 className="text-3xl font-bold">About</h1>
      <p>This is the about page.</p>
    </div>
  );
}
```

### 3. API Integration
```typescript
// src/lib/api.ts
const API_BASE = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001';

export async function fetchAPI(endpoint: string) {
  const response = await fetch(`${API_BASE}${endpoint}`);
  if (!response.ok) {
    throw new Error('API request failed');
  }
  return response.json();
}

// Usage in component
import { useEffect, useState } from 'react';
import { fetchAPI } from '@/lib/api';

export default function DataComponent() {
  const [data, setData] = useState(null);

  useEffect(() => {
    fetchAPI('/api/data')
      .then(setData)
      .catch(console.error);
  }, []);

  return <div>{data ? JSON.stringify(data) : 'Loading...'}</div>;
}
```

### 4. Environment Variables
```typescript
// Environment variables (prefix with NEXT_PUBLIC_ for client-side)
NEXT_PUBLIC_API_URL=http://localhost:3001
NEXT_PUBLIC_APP_NAME=Actual Build
```

## Styling Guidelines

### 1. Tailwind CSS Classes
```typescript
// Use semantic class combinations
<div className="flex items-center justify-between p-4 bg-white rounded-lg shadow-md">
  <h2 className="text-xl font-semibold text-gray-800">Title</h2>
  <button className="px-3 py-1 text-sm bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors">
    Action
  </button>
</div>
```

### 2. Dark Mode Support
```typescript
// Use dark: prefix for dark mode styles
<div className="bg-white dark:bg-gray-800 text-gray-900 dark:text-white">
  <p className="text-gray-600 dark:text-gray-300">Content</p>
</div>
```

### 3. Responsive Design
```typescript
// Mobile-first responsive design
<div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
  <div className="p-4 bg-gray-100 rounded">Card</div>
</div>
```

## Best Practices

### 1. Component Organization
- Keep components small and focused
- Use TypeScript interfaces for props
- Extract reusable logic into custom hooks
- Use server components when possible

### 2. Performance
- Lazy load components with dynamic imports
- Optimize images with Next.js Image component
- Use React.memo for expensive components
- Implement proper error boundaries

### 3. Accessibility
- Use semantic HTML elements
- Add proper ARIA labels
- Ensure keyboard navigation
- Test with screen readers

### 4. Testing
```typescript
// Example test with Jest and Testing Library
import { render, screen } from '@testing-library/react';
import Button from '@/components/Button';

test('renders button with text', () => {
  render(<Button>Click me</Button>);
  expect(screen.getByText('Click me')).toBeInTheDocument();
});
```

## Troubleshooting

### Common Issues

1. **Port already in use**
   ```bash
   npx kill-port 3000
   npm run dev
   ```

2. **Type errors**
   ```bash
   npm run lint
   # Fix TypeScript errors before building
   ```

3. **Build errors**
   ```bash
   rm -rf .next
   npm run build
   ```

4. **Styling issues**
   - Check Tailwind class names
   - Verify CSS import order
   - Clear browser cache

### Performance Issues

1. **Slow development server**
   - Use Turbopack (default in Next.js 15)
   - Reduce bundle size
   - Optimize imports

2. **Large bundle size**
   - Use dynamic imports
   - Remove unused dependencies
   - Analyze bundle with `npm run build`

## Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [React Documentation](https://react.dev/)

## Integration with Backend

The frontend connects to the backend API at `http://localhost:3001`. API endpoints are documented in [API Documentation](./api.md).