FROM golang:1.12.9-stretch

WORKDIR /app
COPY . ./app
RUN ls -alh ./ && git config --global http.sslverify false && update-ca-certificates && go install