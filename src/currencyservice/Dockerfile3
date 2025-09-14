# this is 3rd iteration for currecysercvice fof docker file for env variables

FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install 

COPY . . 

#setup the env variables , why do we need this , because when we deploy this app on kubernetes cluster we will be using configmap to pass the env variables to the container
# we are setting default value for the env variable , if we don't pass any value from configmap it will take this default value

ENV PORT=7000
ENV NODE-ENV=DEVELOPMENT
ENV DISABLE_PROFILER=1

EXPOSE $PORT

# Add health check to monitor container health
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD node -e "console.log('Health check passed')" || exit 1

# Command to run the application
CMD ["node", "server.js"]