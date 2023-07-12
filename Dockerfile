FROM golang:1.19 as build 

WORKDIR /app

COPY . .

# usando nada do CGO  SO linux porque amd64 na minha maquina
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server

FROM scratch

WORKDIR /app
COPY --from=build /app/server .
ENTRYPOINT [ "./server"]
