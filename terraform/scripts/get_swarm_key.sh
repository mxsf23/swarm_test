#!/bin/bash

ssh_remoteaddr=$1
ssh_port=$2

token=$(ssh -i /opt/git_projects/b48/sftest -o StrictHostKeyChecking=no -p $2 ansible@"$1" \
   "sudo docker swarm join-token worker" | grep '[--]token' | awk '{print $5}')
echo '{"token": "'"$token"'"}'