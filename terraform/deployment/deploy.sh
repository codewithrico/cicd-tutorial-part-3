#!/bin/bash

set -e +x

export IMAGE_TAG=$(git rev-parse --short HEAD)

[[ "${IMAGE_TAG}" ]] || (echo "ERROR: IMAGE_TAG not set." && exit 2)
[[ "${LOG_LEVEL}" ]] || (echo "ERROR: LOG_LEVEL not set." && exit 2)
[[ "${ENVIRONMENT}" ]] || (echo "ERROR: ENVIRONMENT not set." && exit 2)
[[ "${AWS_ACCESS_KEY_ID}" ]] || (echo "ERROR: AWS_ACCESS_KEY_ID not set." && exit 2)
[[ "${AWS_SECRET_ACCESS_KEY}" ]] || (echo "ERROR: AWS_SECRET_ACCESS_KEY not set." && exit 2)
[[ "${AWS_DEFAULT_REGION}" ]] || (echo "ERROR: AWS_DEFAULT_REGION not set." && exit 2)

[[ "${MONGO_ROOT_USERNAME}" ]] || (echo "ERROR: MONGO_ROOT_USERNAME not set." && exit 2)
[[ "${MONGO_ROOT_PASSWORD}" ]] || (echo "ERROR: MONGO_ROOT_PASSWORD not set." && exit 2)
[[ "${MONGO_URI}" ]] || (echo "ERROR: MONGO_URI not set." && exit 2)

export TF_VAR_image_tag=$IMAGE_TAG
export TF_VAR_environment=${ENVIRONMENT}
export TF_VAR_log_level=${LOG_LEVEL}

export TF_VAR_mongo_root_username=${MONGO_ROOT_USERNAME}
export TF_VAR_mongo_root_password=${MONGO_ROOT_PASSWORD}
export TF_VAR_mongo_uri=${MONGO_URI}

terraform init \
-no-color \
-backend-config=envs/${ENVIRONMENT}/backend-config.tf \
-reconfigure \
-input=false

terraform plan \
-var-file=envs/${ENVIRONMENT}/vars.tfvars \
-input=false \
-out=./terraform-tanglo-admin-${ENVIRONMENT}.plan

terraform apply \
-no-color \
-input=false \
-auto-approve \
./terraform-tanglo-admin-${ENVIRONMENT}.plan
