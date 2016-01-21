FROM ruby:2.3.0-slim

RUN \
  set -eux ;\
  echo "## mirror ----------------------------" ;\
  sed -i -e 's@http://archive@http://jp.archive@' /etc/apt/sources.list ;\
  apt-get update -qq ;\
  apt-get install -y vim-tiny dialog locales ;\
  echo "## localize --------------------------" ;\
  unlink /etc/localtime ;\
  ln -s /usr/share/zoneinfo/Japan /etc/localtime ;\
  locale-gen ja_JP.UTF-8 ;\
  echo "## cache clear -----------------------" ;\
  mv /etc/apt/sources.list /etc/apt/sources.list.bak ;\
  apt-get clean ;\
  mv /etc/apt/sources.list.bak /etc/apt/sources.list ;\
  echo

RUN \
  apt-get update -qq ;\
  apt-get install -y bundler git libpq-dev libsqlite3-dev rake npm sqlite3 ;\
  apt-get clean ;\
  ln -s /usr/bin/nodejs /usr/local/bin/node ;\
  git clone https://github.com/rutan/potmum.git /srv/potmum ;\
  echo

WORKDIR /srv/potmum

RUN \
  sed -i "s/ruby '2.2.2'/ruby '2.3.0'/g" Gemfile ;\
  bundle install --path vendor/bundle ;\
  echo

RUN \
  sed -i \
    -e 's@adapter: postgresql@<<: *default@g' \
    -e "s@url: <%= ENV\['DATABASE_URL'\] %>@database: db/production.sqlite3@g" \
    config/database.yml ;\
  RAILS_ENV=production \
    bundle exec rake assets:precompile assets:environment db:create db:migrate ;\
  echo

ENV RAILS_ENV="production"
ENV USE_GITHUB=1
ENV GITHUB_KEY="XXXXXXXXXXXXXXXXXXXX"
ENV GITHUB_SECRET="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
EXPOSE 9292
ENTRYPOINT SECRET_KEY_BASE=`rake secret` bundle exec puma
