FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /e-sportsBet
WORKDIR /e-sportsBet
COPY Gemfile /e-sportsBet/Gemfile
COPY Gemfile.lock /e-sportsBet/Gemfile.lock
RUN bundle install
COPY . /e-sportsBet
