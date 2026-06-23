FROM golang:1.25-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libc6-dev \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY whatsapp-bridge/ .

RUN go get go.mau.fi/whatsmeow@latest && go mod tidy

RUN CGO_ENABLED=1 GOOS=linux go build -o /whatsapp-bridge .

EXPOSE 8080

CMD ["/whatsapp-bridge"]
