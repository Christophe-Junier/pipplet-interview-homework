FROM ruby:2.7.2
LABEL maintainer="adrien@pipplet.com"

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
CMD ["bundle","exec","puma","-C","config/puma.rb"]
