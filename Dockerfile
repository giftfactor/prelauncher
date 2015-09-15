FROM ruby:2.1.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir -p /tmp
WORKDIR /tmp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

ENV BUNDLE_GEMFILE=/tmp/Gemfile
ENV BUNDLE_JOBS=2
ENV BUNDLE_PATH=/bundle
RUN bundle install

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME
