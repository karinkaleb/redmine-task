FROM redmine:5.1.12

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential git && \
    rm -rf /var/lib/apt/lists/*

COPY ./plugins /usr/src/redmine/plugins
COPY ./themes /usr/src/redmine/public/themes
COPY ./conf.d/configuration.yml /usr/src/redmine/config/configuration.yml

WORKDIR /usr/src/redmine

USER redmine

RUN bundle install --without development test

USER root

EXPOSE 3000