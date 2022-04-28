FROM python:3.6-alpine

ARG CURATOR_VERSION

RUN pip install --upgrade urllib3==1.25.4 &&\
    pip install  elasticsearch-curator==${CURATOR_VERSION} &&\
    pip install pyyaml==5.4.1 &&\
    rm -rf /var/cache/apk/*

COPY ./ /config/
RUN /usr/bin/crontab /config/crontab.txt

CMD ["/usr/sbin/crond","-f"]