FROM nginx:1.17

WORKDIR /usr/share/nginx/html
COPY _site/ .

EXPOSE 80:80
