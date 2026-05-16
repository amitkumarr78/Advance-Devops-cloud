FROM nginx:latest

COPY . /usr/share/nginx/html

EXPOSE 80
# Taking it out from folder to show properly