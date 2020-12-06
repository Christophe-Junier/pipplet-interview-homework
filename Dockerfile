FROM ruby:2.7.2
LABEL maintainer="adrien@pipplet.com"

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev cron

RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime
ENV LANG C.UTF-8

RUN mkdir -p /pipplet
WORKDIR /pipplet

# Install necessary gems
RUN gem install bundler
ADD Gemfile /pipplet/Gemfile
ADD Gemfile.lock /pipplet/Gemfile.lock
RUN bundle install

# Adding schedule
ADD ./config/schedule.rb /pipplet/config/

# Expose our server port.
EXPOSE 3000

# Adding log
Run mkdir ./log

# Running whenever
RUN bundle exec whenever && touch ./log/cron.log

# Setting log entrypoint
ENTRYPOINT crond && tail -f ./log/cron.log

# Start server
CMD ["bundle","exec","puma","-C","config/puma.rb"]
