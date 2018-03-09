#!/bin/bash

set -ux

EXIT_CODE=1

sleep 10
while true ; do
  echo "Waiting for RabbitMQ pod to be ready...."
  rabbitmqctl -n rabbit@rabbitmq-0.rmq-cluster status
  EXIT_CODE=$?
  if [[ "$EXIT_CODE" == "0" ]]; then
    echo "rabbitmq-0 pod ready ,setting ha policy: $RABBITMQ_HA_POLICY"
    sleep 5
    rabbitmqctl -n rabbit@rabbitmq-0.rmq-cluster set_policy ha-all '.*' "$RABBITMQ_HA_POLICY" --apply-to queues
    echo "ha-all policy set successfully"
    break
  fi
  echo "RabbitMQ pod still not ready..."
  sleep 5
done
