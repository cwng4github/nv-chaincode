# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

RUN mkdir -p /go/src/github.com/hyperledger
RUN cd /go/src/github.com/hyperledger
WORKDIR /go/src/github.com/hyperledger
RUN git clone https://github.com/hyperledger-archives/fabric.git

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/cwng4github/nv-chaincode
RUN cd /go/src/github.com/cwng4github/nv-chaincode
WORKDIR /go/src/github.com/cwng4github/nv-chaincode

RUN go build
RUN chmod +x nv-chaincode

CMD CORE_CHAINCODE_ID_NAME=mycc CORE_PEER_ADDRESS=172.17.0.3:7051 /go/src/github.com/cwng4github/nv-chaincode/nv-chaincode

# Document that the service listens on port 8080.
#EXPOSE 8080