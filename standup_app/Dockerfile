FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /standup_app
WORKDIR /standup_app
ADD Gemfile /standup_app/Gemfile
ADD Gemfile.lock /standup_app/Gemfile.lock
RUN bundle install
ADD . /standup_app

