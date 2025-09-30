# 1st iteration of Dcokerfile for the productcatalogservice
# this is written with Go language so we need to build dockerfile for GO language

FROM golang:1.23-alpine

# Now we set the working dir for  our app
WORKDIR /app 

# Now we copy the go mod and sum file to download the dependencies and then we will copy the rest of the files
COPY go.mod go.sum ./

# Now we download the dependencies and install them
RUN go mod download 

# now copy the rest of the files
COPY . . 

# Build the go application 
RUN go build -o server .

# Expose the port that the app runs on 
EXPOSE 3550

# Now the final stage , we will run the applciation 
CMD ["./server"]