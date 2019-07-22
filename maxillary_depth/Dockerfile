FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /maxillary_depth

WORKDIR /maxillary_depth

ADD Gemfile /maxillary_depth/Gemfile
ADD Gemfile.lock /maxillary_depth/Gemfile.lock

RUN bundle install
ADD . /maxillary_depth