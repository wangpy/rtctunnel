FROM golang:1.12-alpine as builder
RUN apk --no-cache add git

ENV GO111MODULE=on
RUN mkdir -p /go/src/github.com/wangpy/rtctunnel
WORKDIR /go/src/github.com/wangpy/rtctunnel

COPY go.mod .
COPY go.sum . 
RUN go mod download

COPY channels channels
COPY cmd cmd 
COPY crypt crypt 
COPY peer peer 
COPY signal signal 

RUN go build -v -o /bin/rtctunnel ./cmd/rtctunnel