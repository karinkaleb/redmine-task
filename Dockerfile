FROM redmine:6

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    rm -rf /var/lib/apt/lists/*

COPY ./plugins /usr/src/redmine/plugins
COPY ./themes /usr/src/redmine/public/themes

USER redmine
RUN bundle install --without development test

USER root
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]