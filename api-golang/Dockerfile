FROM golang:1.19-buster AS base

WORKDIR /app

COPY go.mod go.sum ./

# RUN go mod download

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go mod download

FROM base AS dev

RUN go install github.com/cosmtrek/air@latest && \
    go install github.com/go-delve/delve/cmd/dlv@latest

COPY . .

CMD ["air", "-c", ".air.toml"]

FROM base AS production

RUN useradd -u 1001 nonroot

COPY . .

# RUN go build -o api-golang

RUN go build \
    -ldflags="-linkmode external -extldflags -static" \
    -tags netgo \
    -o healthcheck \
    ./healthcheck/healthcheck.go

RUN go build \
    -ldflags="-linkmode external -extldflags -static" \
    -tags netgo \
    -o api-golang

FROM scratch

COPY --from=production /etc/passwd /etc/passwd

# Copy the healthcheck binary from the build stage
COPY --from=production /app/healthcheck/healthcheck healthcheck

COPY --from=production /app/api-golang api-golang

USER nonroot

EXPOSE 8080

CMD ["/api-golang"]