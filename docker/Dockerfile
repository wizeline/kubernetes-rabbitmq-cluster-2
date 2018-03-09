FROM rabbitmq:3.6-management-alpine

RUN apk add --update jq curl bash

COPY rabbitmq_delayed_message_exchange-0.0.1.ez /plugins
COPY rabbitmq_clusterer-1.0.3.ez  /plugins
RUN rabbitmq-plugins enable rabbitmq_delayed_message_exchange --offline
RUN rabbitmq-plugins enable rabbitmq_clusterer --offline

ENV RABBITMQ_LOG_LEVEL=info
ENV RABBITMQ_BOOT_MODULE rabbit_clusterer
ENV RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS "-pa /plugins/rabbitmq_clusterer-1.0.3.ez/rabbitmq_clusterer-1.0.3/ebin"
COPY clusterer.config /etc/rabbitmq/

COPY set_cluster_nodes.sh /
COPY set_ha.sh /

RUN chown -R rabbitmq:rabbitmq /var/lib/rabbitmq /etc/rabbitmq \
    && chmod +x /set_ha.sh /set_cluster_nodes.sh
COPY docker-entrypoint.sh /usr/local/bin/
