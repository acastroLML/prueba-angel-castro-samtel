FROM nginx:alpine

ADD ./dist /var/www/
ADD ./nginx.default.conf /etc/nginx/conf.d/default.conf