## Dockerfile
```
FROM node:6

WORKDIR /app

#install dependences
COPY package.json .

RUN npm install cnpm -g --registry=https://registry.npm.taobao.org && cnpm install

# Bundle app source
COPY . .

RUN npm run build


FROM mhart/alpine-node:6
WORKDIR /app

RUN apk add --no-cache curl

COPY --from=0 /app .

RUN cp -r .server/* .

CMD ["node", "bin/www"]


```

## docker-compose.yml
```
version: '3'
services:
  cf-admin:
    image: $IMAGE
    networks:
      - my-net
    ports:
      - "${PORT}:${PORT}"
    environment:
      PORT: "${PORT}"
      NODE_ENV: "${ENV}"
    deploy:
      mode: replicated
      replicas: 3
      resources:
        limits:
          # cpus: '0.6'
          memory: 400M
        reservations:
          # cpus: '0.01'
          memory: 100M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:${PORT}/healthcheck"]
      interval: 30s
      timeout: 10s
      retries: 3
    labels:
      - "traefik.docker.network=${NETWORK}"
      - "traefik.backend=restapi"
      - "traefik.backend.healthcheck.path=/healthcheck"
      - "traefik.backend.healthcheck.interval=10s"
      - "traefik.frontend.rule=Host:${HOST}"
      - "traefik.enable=true"
      - "traefik.port=${PORT}"
      - "version=${VERSION}"

networks:
  my-net:
    external:
      name: ${NETWORK}

```

## .env (default parameters)
```
PORT=3000
NETWORK_MODE="host"
```

## .dockerignore
