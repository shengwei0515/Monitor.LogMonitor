FROM fluent/fluentd:v1.14.6-debian-armhf-1.0
# Use root account to use apt
USER root
ARG ELASTICSEARCH_PLUGIN_VERSION
# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apt-get purge' has no effect

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish

# Issue of elasticsearch api version: https://github.com/uken/fluent-plugin-elasticsearch/issues/935
RUN buildDeps="sudo make gcc g++ libc-dev" \
   && apt-get update \
   && apt-get install -y --no-install-recommends $buildDeps \
   && sudo gem install --no-document\
   elasticsearch:${ELASTICSEARCH_PLUGIN_VERSION} \
   fluent-plugin-elasticsearch \
   fluent-plugin-multi-format-parser \
   fluent-plugin-beats \
   fluent-plugin-record-reformer \
   && sudo gem sources --clear-all \
   && SUDO_FORCE_REMOVE=yes \
   apt-get purge -y --auto-remove \
                 -o APT::AutoRemove::RecommendsImportant=false \
                 $buildDeps \
   && rm -rf /var/lib/apt/lists/* \
   && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent