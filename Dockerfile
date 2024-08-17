FROM node:18-alpine as builder

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

# Используем ARG для переменных, которые могут меняться при сборке
ARG VITE_APP_TEST=Default
ENV VITE_APP_TEST=$VITE_APP_TEST

RUN yarn build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]