FROM ruby:2.1.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# see http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
# Copy the Gemfile and Gemfile.lock into the image.
# Temporarily set the working directory to where they are.
WORKDIR /tmp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

RUN mkdir /myapp
WORKDIR /myapp
ADD . /myapp
