FROM ruby

#no verbose output
ENV DEBIAN_FRONTEND noninteractive

RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential vim yarn libpq-dev nodejs imagemagick \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

#apps directory
RUN mkdir /app

#workspace
WORKDIR /app

#add gemfile* proyecto to rails_apps dir
ADD Gemfile /app/Gemfile

ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

#add all files to rails_apps
ADD . /app

EXPOSE 3000

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]
