# we are going to build multi stage docker file
# 3rd iteration of the dockerfile

# Basic image for 1st stage
FROM golang:1.23-alpine AS builder

# Create the working dir
WORKDIR /app

# copy the dep, libraies to this dir
COPY go.mod go.sum ./

# now donwload the packages
RUN go mod download

# now copy the source code
COPY . .

# build the application 
RUN go build -o server .

# now see what are the files exist
# RUN ls -la app/server
RUN ls -la /app/server


# now we need to create the 2nd stage of the dockerfile
FROM alpine:latest

RUN apk add --no-cache ca-certificates

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /app/server .

COPY products.json .

RUN chown -R appuser:appgroup /app
USER appuser
EXPOSE 3550
CMD ["/app/server"]
