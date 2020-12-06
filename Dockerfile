FROM ruby:2.7.2
LABEL maintainer="adrien@pipplet.com"

RUN apt-get update
RUN apt-get install -qq -y --no-install-recommends apt-utils build-essential libpq-dev cron
RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime

ENV LANG C.UTF-8
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

# Start server
RUN bash -c "bundle exec whenever --update-crontab && cron -f"
CMD ["bundle","exec","puma","-C","config/puma.rb"]
