FROM node:20-slim

# Create app directory and use non-root 'node' user
WORKDIR /home/node/app

# Copy package files first for deterministic install
COPY --chown=node:node package.json package-lock.json ./

ENV NODE_ENV=production

# Install production dependencies deterministically using package-lock.json
RUN npm ci --omit=dev --no-audit --no-fund

# Copy application source
COPY --chown=node:node . .

# Use non-root user from the base image
USER node

# Application listens on 8000 by default
EXPOSE 8000

# Ensure the app binds to 0.0.0.0 by relying on its PORT handling
ENV PORT=8000

CMD ["npm", "start"]
