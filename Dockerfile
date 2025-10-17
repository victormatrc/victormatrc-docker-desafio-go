FROM golang:1.25.3-alpine3.22 AS builder

COPY  ./src/ /go/src

WORKDIR /go/src/FullCycleRocks

RUN go mod init example/hello

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 && \
    go build -ldflags="-s -w" -o .
# ENTRYPOINT [ "./hello"]
# ENTRYPOINT [ "bash"]




FROM scratch
WORKDIR /go/src/FullCycleRocks
COPY --from=builder /go/src/FullCycleRocks/hello .
CMD ["./hello"]
