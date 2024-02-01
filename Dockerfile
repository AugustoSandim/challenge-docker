# syntax=docker/dockerfile:1

FROM golang:1.21-alpine AS builder

WORKDIR /app

# Initialize the module
RUN go mod init hello

# Copy the source code
COPY ./hello.go .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -o hello .

FROM scratch

# Copy the binary from the builder stage
COPY --from=builder /app/hello .

# Run the binary
CMD ["./hello"]
