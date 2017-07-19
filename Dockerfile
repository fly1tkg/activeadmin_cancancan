FROM ruby:2.4.1

ENV APP_ROOT /usr/src/rails_app

WORKDIR $APP_ROOT

RUN apt-get update && \
    apt-get install -y nodejs \
                       mysql-client \
                       postgresql-client \
                       sqlite3 \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

#
#COPY ./app $APP_ROOT/app
#COPY ./config $APP_ROOT/config
#COPY ./db $APP_ROOT/db
#COPY ./lib $APP_ROOT/lib
#COPY ./public $APP_ROOT/public
#COPY ./test $APP_ROOT/test
#COPY ./vendor $APP_ROOT/vendor
#COPY Gemfile $APP_ROOT
#COPY Gemfile.lock $APP_ROOT

EXPOSE  3000
