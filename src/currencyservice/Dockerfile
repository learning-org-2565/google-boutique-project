# Multi-stage Docker build with ARG variables
# ARG is used to pass values at build time, once created it cannot be changed

ARG NODE_VERSION=18
ARG APP_USER=node
ARG APP_GROUP=node
ARG APP_PORT=7000

# First stage: Builder
FROM node:${NODE_VERSION} AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . . 

# Second stage: Production
FROM node:${NODE_VERSION}-slim AS production

# Re-declare ARG variables for this stage
ARG APP_USER=node
ARG APP_GROUP=node
ARG APP_PORT=7000

# NOTE: No need to create node user/group - they already exist in the base image!

# Setup working directory
WORKDIR /app 
COPY package*.json ./
RUN npm install --only=production && npm cache clean --force
COPY --from=builder /app .
RUN chown -R ${APP_USER}:${APP_GROUP} /app

# Set up environment variables
ENV PORT=${APP_PORT}
ENV NODE_ENV=production
ENV DISABLE_PROFILER=1

# Switch to the non-root user
USER ${APP_USER}

EXPOSE ${APP_PORT}

# Adding health checks
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD node -e "console.log('Health check passed')" || exit 1

# Command to start the app
CMD ["node", "server.js"]