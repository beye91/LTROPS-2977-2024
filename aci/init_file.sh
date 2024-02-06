#! /bin/bash
PROJECT_ID="${CI_PROJECT_ID}" \
TF_USERNAME=${TF_USERNAME} \
TF_PASSWORD=${TF_PASSWORD} \
TF_ADDRESS="https://198.18.133.99/api/v4/projects/${PROJECT_ID}/terraform/state/terraform_statefile" \

terraform init \
  -backend-config=address=${TF_ADDRESS} \
  -backend-config=lock_address=${TF_ADDRESS}/lock \
  -backend-config=unlock_address=${TF_ADDRESS}/lock \
  -backend-config=username=${TF_USERNAME} \
  -backend-config=password=${TF_PASSWORD} \
  -backend-config=lock_method=POST \
  -backend-config=unlock_method=DELETE \
  -backend-config=retry_wait_min=5 