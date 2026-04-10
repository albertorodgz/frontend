FROM nginx:alpine

RUN mkdir -p /usr/share/nginx/html/images /usr/share/nginx/html/css

COPY app/*.html /usr/share/nginx/html/
COPY app/css/*.css /usr/share/nginx/html/css/
COPY app/images/*.j* /usr/share/nginx/html/images/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]