# Shared

This directory contains shared utilities, types, and configurations used by both frontend and backend.

## Contents

```
shared/
├── types/            # TypeScript type definitions
├── utils/            # Shared utility functions
├── constants/        # Application constants
├── validators/       # Input validation schemas
├── config/           # Shared configuration
└── README.md         # This file
```

## Usage

Import shared modules in your frontend or backend code:

```javascript
// Frontend
import { ApiResponse } from '../shared/types/api';
import { validateEmail } from '../shared/validators/user';

// Backend
import { UserType } from '../shared/types/user';
import { formatResponse } from '../shared/utils/response';
```

## Types

Common TypeScript interfaces and types:
- User types
- API response types
- Database model types
- Configuration types

## Utilities

Shared functions that can be used across the application:
- Data formatting
- Validation helpers
- Common calculations
- API helpers

## Constants

Application-wide constants:
- Error messages
- Status codes
- Configuration values
- Default settings