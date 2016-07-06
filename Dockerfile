FROM ruby:2.2.2
MAINTAINER Joshua Stowers <stowers.joshua@live.com>

ENV TTT_ENV production
ENV MAIN_APP_FILE ./app.rb

ADD startup.sh /
COPY . /

CMD "/startup.sh"
