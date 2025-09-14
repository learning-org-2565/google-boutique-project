# this is the 4th iteration of the docker file which is going to focus on security aspect of the docker image

# we are going to use base image to reduce the time and make the readymade image

FROM  node:18

# create the working dir on top of that we will execute the source code 
WORKDIR /app

# now we will copy the package.json file to install and dependencies 
COPY package*.json ./

# now install the npm to download the dependencies like node modules
RUN npm install

# now copy the source code to the working dir

COPY . . 

# we need to change the rootuser to non root user for security purposes
RUN chown -R  node:node /app

ENV PORT=7000

# We need to switch to the non root user
USER node

# we need to expose the port
EXPOSE $PORT

# NOW THE final step CMD commmand to run the app
CMD ["node", "server.js"]

# This image size is currencyservice-currencyservice  latest 7634dec7b671  1.3GB