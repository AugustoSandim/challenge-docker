# syntax=docker/dockerfile:1

FROM golang:1.21-alpine AS builder

WORKDIR /app

# Download Go modules
RUN go mod init example/hello

# Copy the source code
COPY ./hello.go .

# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/engine/reference/builder/#copy
RUN CGO_ENABLED=0 GOOS=linux go build -o hello .

FROM scratch

# Copy the binary from the builder stage
COPY --from=builder /app/hello .

# Run the binary
CMD ["./hello"]
