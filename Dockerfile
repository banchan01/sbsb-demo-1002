FROM node:20-slim

# Create app directory
WORKDIR /usr/src/app

# Copy package manifests first to leverage Docker layer caching
COPY package.json package-lock.json ./

# Install only production dependencies deterministically
RUN npm ci --omit=dev

# Copy application source
COPY server.js ./

# Ensure non-root runtime user owns the app files
RUN chown -R node:node /usr/src/app

# Use a non-root user
USER node

# Expose the application's port (default 8000)
EXPOSE 8000

# Set NODE_ENV for production behavior
ENV NODE_ENV=production

# Default command
CMD ["npm", "start"]
