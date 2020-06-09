FROM ruby:2.7.1
RUN apt-get update -qq \
    && apt-get install -y nodejs postgresql-client
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn
RUN mkdir /rails-docker
WORKDIR /rails-docker
COPY Gemfile /rails-docker/Gemfile
COPY Gemfile.lock /rails-docker/Gemfile.lock
RUN bundle install
COPY . /rails-docker

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
