# Stage 1: Build
FROM golang:1.23.10-alpine3.21 AS builder

# Install dependencies
RUN apk update && apk add --no-cache git openssh tzdata build-base python3 net-tools

# Set working directory
WORKDIR /app

# Copy project files
COPY .env.example .env
COPY . .

# (Opsional) Install CLI tools atau dependencies Go
RUN go install github.com/buu700/gin@latest

# Download Go modules
RUN go mod tidy

# Build project
RUN make build

# Stage 2: Runtime
FROM alpine:latest

# Install runtime dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache tzdata curl

# Buat folder kerja
WORKDIR /app

# Expose port
EXPOSE 8001

# Copy hasil build dari stage builder
COPY --from=builder /app /app

# Jalankan binary utama
ENTRYPOINT ["/app/user-service"]
