FROM golang:1.24-alpine AS builder

WORKDIR /src
COPY go.mod main.go main_test.go ./
RUN go test ./... \
    && CGO_ENABLED=0 GOOS=linux go build -o /out/hello .

FROM alpine:3.22

RUN apk add --no-cache ca-certificates \
    && addgroup -S app \
    && adduser -S -G app app
COPY --from=builder /out/hello /usr/local/bin/hello
USER app
ENTRYPOINT ["hello"]

