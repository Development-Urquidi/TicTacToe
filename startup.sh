#!/bin/bash
if [ "$TTT_ENV" == "production" ];
then
  bundle install --without development test
else
  bundle install
  if [ "$TTT_ENV" == "test" ];
  then
    bundle exec rspec spec
  fi
fi
ruby ./app.rb

