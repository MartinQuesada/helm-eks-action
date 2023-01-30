#!/bin/sh -x

set -e

aws eks update-kubeconfig \
  --region ${AWS_REGION} \
  --name ${CLUSTER_NAME} --kubeconfig kubeconfig

export KUBECONFIG="${PWD}/kubeconfig"

echo "running entrypoint command(s)"

response=$(sh -c " $*")

echo "response=$response" >> $GITHUB_ENV
