#!/bin/bash

echo "Check if image exists..."
code=$(yc compute image get ubuntu-docker > /dev/null 2>&1;echo $?) 

if [ $code -ne 0 ]; then
    pushd packer
    echo "Building Image..."
    export YC_FOLDER_ID=$(yc config get folder-id)
    export YC_ZONE="ru-central1-a"
    export YC_SUBNET_ID=$(yc vpc subnet get default-ru-central1-a --format json | jq -r .id)
    export YC_TOKEN=$(yc iam create-token)

    packer validate prepare_image.pkr.hcl && packer build prepare_image.pkr.hcl

    popd
fi

pushd terraform
echo "Running Terraform to deply app..."
terraform apply -auto-approve
popd
