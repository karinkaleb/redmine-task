FROM redmine:6

COPY ./themes /usr/src/redmine/public/themes
COPY ./plugins /usr/src/redmine/plugins

EXPOSE 3000