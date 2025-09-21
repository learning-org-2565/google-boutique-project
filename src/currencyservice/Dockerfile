ARG NODE_VERSION=18
ARG APP_USER=node
ARG APP_GROUP=node
ARG APP_PORT=7000

# ---- Stage 1: Builder ----
FROM node:${NODE_VERSION} AS builder
LABEL maintainer="arunponugoti2565@gmail.com"
LABEL version="1.0.0"
LABEL environment="production"

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# ---- Stage 2: Production ----
FROM node:${NODE_VERSION}-slim AS production

ARG NODE_VERSION=18
ARG APP_USER=node
ARG APP_GROUP=node
ARG APP_PORT=7000

# Install curl and clean up in one layer
RUN apt-get update \
  && apt-get install -y --no-install-recommends curl \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /app

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production \
  && npm cache clean --force \
  && rm -rf /tmp/*

# Copy built application from builder stage
COPY --from=builder /app .

# Adjust permissions (node user already exists in the base image)
RUN chown -R ${APP_USER}:${APP_GROUP} /app \
  && chmod +x /app/server.js

# Environment variables
ENV PORT=${APP_PORT} \
    NODE_ENV=production \
    DISABLE_PROFILER=1

# Run as non-root user
USER ${APP_USER}

# Expose app port
EXPOSE ${APP_PORT}

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${APP_PORT}/health || exit 1

# Start app
CMD ["node", "server.js"]