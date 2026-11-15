# Build stage
FROM golang:1.23-bookworm AS builder

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -trimpath \
    -ldflags="-s -w" \
    -o /out/dummy_exporter .

# Runtime stage
FROM gcr.io/distroless/static-debian12:nonroot

WORKDIR /

COPY --from=builder /out/dummy_exporter /bin/dummy_exporter
COPY example/simple.yml /etc/dummy_exporter.yml

EXPOSE 9510

USER nonroot:nonroot

ENTRYPOINT ["/bin/dummy_exporter"]
CMD ["--config=/etc/dummy_exporter.yml"]
