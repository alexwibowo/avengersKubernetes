FROM httpd:2.4.48-alpine

ARG user=ironman
ARG group=avengers
ARG uid=1000
ARG gid=1000
ENV APP_HOME=/app/kubedemo

RUN set -eux \
    && addgroup -g ${gid} -S ${group} \
    && adduser -u ${uid} -S -D -G ${group} -H -h ${APP_HOME} -s /bin/bash ${user} \
    && mkdir -p ${APP_HOME} \
    && chown -R ironman:avengers ${APP_HOME}

COPY conf/proxy.conf /usr/local/apache2/conf/kubedemo.conf

EXPOSE 7000

RUN sed -i 's/Listen 80/Listen 7000/' /usr/local/apache2/conf/httpd.conf \
    && echo 'IncludeOptional /usr/local/apache2/conf/kubedemo.conf' >> /usr/local/apache2/conf/httpd.conf