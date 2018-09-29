FROM nginx

#install packages and clean
RUN apt-get update -qq && apt-get -y install apache2-utils vim \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

#set rails_root
ENV RAILS_ROOT /var/www/rails_app_dir

#workspace
WORKDIR $RAILS_ROOT

#create log
RUN mkdir log

#copy public files
COPY public public/

#copy conf nginx to tmp dir
COPY docker/web/app.conf /tmp/docker_example.nginx

#set conf nginx
RUN envsubst '$RAILS_ROOT' < /tmp/docker_example.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
