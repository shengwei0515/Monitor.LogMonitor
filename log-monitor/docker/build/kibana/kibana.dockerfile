ARG KIBANA_VERSION # this setting for docker image version

FROM docker.elastic.co/kibana/kibana:${KIBANA_VERSION}

USER root

ARG KIBANA_VERSION  # this setting for KIBANA_PLUGIN_URL
ARG KIBANA_PLUGIN_URL="https://github.com/Karql/elastalert-kibana-plugin/releases/download/1.4.0/elastalertKibanaPlugin-1.4.0-${KIBANA_VERSION}.zip"

RUN /usr/share/kibana/bin/kibana-plugin install $KIBANA_PLUGIN_URL

USER kibana