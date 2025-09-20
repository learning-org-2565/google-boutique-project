# Now we are going to create 7th iteration of Docker
# Here we will focus more on the Labes

ARG NODE_VERSION=18
ARG APP_USER=node
ARG APP_GROUP=node
ARG APP_PORT=7000

# Labels are used to add metadata to the image like maintainer info , version info and discription
# Labels are key value pairs
# LABEL maintainer="Arun-Ponugoti"
# LABEL version="1.0.0"
# LABEL description="Currency Service for Microservices demo application"
# LABEL microservice="currencyservice"
# LABEL environment="production"


# now let's build new docker file with multi stage build 

FROM node:${NODE_VERSION} AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .


# Now we will create 2nd stage of  the docker file
FROM node:${NODE_VERSION}-slim AS production

LABEL stage="production"
LABEL build.stage="final"
LABEL org.opencontainers.image.source="https://github.com/your/repo"

WORKDIR /app
COPY package*.json ./
RUN npm install --only=production && npm cache clean --force
COPY --from=builder /app .

RUN chown -R ${APP_USER}:${APP_GROUP} /app

# set up env variables
ENV PORT=${APP_PORT}
ENV NODE_ENV=production
ENV DISABLE_PROFILER=1

USER ${APP_USER}

EXPOSE ${APP_PORT}

# Adding health checks
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD node -e "console.log('Health check passed')" || exit 1

CMD ["node", "server.js"]
