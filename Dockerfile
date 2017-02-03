FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /indiegogo
WORKDIR /indiegogo

ADD Gemfile /indiegogo/Gemfile
ADD Gemfile.lock /indiegogo/Gemfile.lock
RUN bundle install

ADD . /indiegogo
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
