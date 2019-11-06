FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm config set proxy "http://inban1b-proxy.apac.nsn-net.net:8080/"
RUN npm config set https-proxy "http://inban1b-proxy.apac.nsn-net.net:8080/"
RUN npm config set registry https://registry.npmjs.org/
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html