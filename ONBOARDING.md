# Shopizer Admin - Developer Onboarding Guide

## Prerequisites

- **NVM (Node Version Manager)** - Required for managing Node versions
- **Java 11** - For running the backend
- **Maven** - For building the backend

## Quick Start

### Option 1: Automated Setup (Recommended)

```bash
./setup.sh
```

This script will:
- Check for NVM installation
- Install Node v12.22.7 if needed
- Switch to the correct Node version
- Install Angular CLI globally
- Clean up old dependencies
- Install project dependencies with `--legacy-peer-deps`

### Option 2: Manual Setup

1. **Install correct Node version:**
   ```bash
   nvm install v12.22.7
   nvm use v12.22.7
   ```

2. **Install Angular CLI:**
   ```bash
   npm install -g @angular/cli@13.3.11
   ```

3. **Install dependencies:**
   ```bash
   rm -rf node_modules package-lock.json
   npm install --legacy-peer-deps
   ```

4. **Run the application:**
   ```bash
   ng serve -o
   ```

## Common Issues

### Issue: `fibers` build failure with Node v24+

**Cause:** The `fibers` package (used by Sass) doesn't support Node versions beyond v14.

**Solution:** Use Node v12.22.7 as specified in `.nvmrc`

```bash
nvm use
npm install --legacy-peer-deps
```

### Issue: Peer dependency conflicts

**Cause:** Angular 11 has strict peer dependency requirements.

**Solution:** Always use `--legacy-peer-deps` flag:

```bash
npm install --legacy-peer-deps
```

### Issue: Backend connection errors

**Cause:** Backend API not running or wrong URL.

**Solution:** 
1. Start backend from `../shopizer/sm-shop` directory
2. Verify backend is running on `http://localhost:8080/api`
3. Check `src/environments/environment.ts` for API URL configuration

## Project Information

- **Node Version:** v12.22.7 (specified in `.nvmrc`)
- **Angular Version:** 11.2.14
- **Angular CLI:** 13.3.11
- **TypeScript:** 4.0.8

## Running the Application

1. **Ensure backend is running:**
   ```bash
   cd ../shopizer/sm-shop
   mvn spring-boot:run
   ```

2. **Start admin panel:**
   ```bash
   ./start.sh
   ```
   
   This script automatically:
   - Loads NVM
   - Switches to Node v12.22.7
   - Starts the dev server with `ng serve -o`

   **Alternative (manual):**
   ```bash
   nvm use  # Uses version from .nvmrc
   ng serve -o
   ```

3. **Access application:**
   - URL: http://localhost:4200
   - Username: `admin@shopizer.com`
   - Password: `password`

## Development Commands

```bash
# Start dev server
ng serve

# Build for production
ng build --prod

# Run tests
npm test

# Run linting
npm run lint

# Fix linting issues
npm run lint:fix
```

## Environment Modes

The application supports three modes (configured in `environment.ts`):

- **STANDARD** - Single store mode
- **MARKETPLACE** - Multi-vendor marketplace
- **B2B** - Business-to-business mode

## Useful Tips

1. **Auto-switch Node version:** With `.nvmrc` in place, just run `nvm use` in the project directory

2. **Add to shell profile:** Auto-load correct Node version when entering directory:
   ```bash
   # Add to ~/.zshrc or ~/.bashrc
   autoload -U add-zsh-hook
   load-nvmrc() {
     if [[ -f .nvmrc && -r .nvmrc ]]; then
       nvm use
     fi
   }
   add-zsh-hook chpwd load-nvmrc
   ```

3. **Backend API endpoints:** Check `src/app/pages/shared/services/` for API service implementations

4. **Role-based access:** Review `src/app/pages/pages-menu.ts` to understand permission guards

## Need Help?

- Check the main README.md for additional information
- Review Angular 11 documentation: https://v11.angular.io/
- Review Nebular UI documentation: https://akveo.github.io/nebular/
