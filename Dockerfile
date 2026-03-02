# =============================================================================
# stage 1: builder
# =============================================================================
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .
COPY templates/ .

RUN CGO_ENABLED=0 go build -o test .

# =============================================================================
# stage 2: runtime (final image)
# =============================================================================
FROM scratch

COPY --from=builder test .
COPY --from=builder templates/ .

CMD ["test"]