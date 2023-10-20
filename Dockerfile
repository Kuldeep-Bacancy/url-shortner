FROM ruby:3.1.2 as base

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs yarn

WORKDIR /url-shortner

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

ADD . /url-shortner

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}

CMD [ "bundle","exec", "rails", "s", "-b", "0.0.0.0"]