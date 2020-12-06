FROM ruby:2.7.2
LABEL maintainer="adrien@pipplet.com"

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev cron

RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime
ENV LANG C.UTF-8
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_ENV development

RUN mkdir -p /pipplet
WORKDIR /pipplet

# Install necessary gems
RUN gem install bundler
ADD Gemfile /pipplet/Gemfile
ADD Gemfile.lock /pipplet/Gemfile.lock
RUN bundle install

# Expose our server port.
EXPOSE 3000

# Running server
CMD bash -c "bundle exec whenever --update-crontab && cron -f && bundle exec puma -c config/puma.rb"
