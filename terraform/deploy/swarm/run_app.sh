#!/usr/bin/env bash

script_path=$(dirname $0)

until [ $(docker node ls --quiet --filter role=worker | wc -l)  -gt 1 ]
do
  echo "Waiting for worker nodes....";
  echo "Current number of worker nodes - $(docker node ls --quiet --filter role=worker | wc -l)";
  sleep 5;

done

for i in $(docker node ls --quiet --filter role=worker)
do
  echo "Worker - $i"
  docker node update --label-add role=worker $i
  docker stack deploy -c $script_path/docker-compose.yaml socks_app
done
