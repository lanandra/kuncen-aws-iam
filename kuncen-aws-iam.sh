#!/usr/bin/env bash

DATETIMENOW=$(date)
echo "[${DATETIMENOW}] generating information..."

if [[ ${KUNCEN_AWS_IAM_INTERVAL} == '' ]] && [[ ${KUNCEN_AWS_IAM_OUTPUT} == '' ]]
then
  docker run \
    -it \
    --rm \
    -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
    -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
    --name steampipe-container-agent \
    --mount type=bind,source="${PWD}",target=/output \
      lanandra/steampipe-container-agent query "select access_key_id, user_name, create_date from aws_iam_access_key where create_date < current_date - interval '90' day" --output table
elif [[ ${KUNCEN_AWS_IAM_INTERVAL} == '' ]]
then
  docker run \
    -it \
    --rm \
    -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
    -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
    --name steampipe-container-agent \
    --mount type=bind,source="${PWD}",target=/output \
      lanandra/steampipe-container-agent query "select access_key_id, user_name, create_date from aws_iam_access_key where create_date < current_date - interval '90' day" --output ${KUNCEN_AWS_IAM_OUTPUT}
elif [[ ${KUNCEN_AWS_IAM_OUTPUT} == '' ]]
then
  docker run \
    -it \
    --rm \
    -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
    -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
    --name steampipe-container-agent \
    --mount type=bind,source="${PWD}",target=/output \
      lanandra/steampipe-container-agent query "select access_key_id, user_name, create_date from aws_iam_access_key where create_date < current_date - interval '${KUNCEN_AWS_IAM_INTERVAL}' day" --output table
else
  docker run \
    -it \
    --rm \
    -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
    -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
    --name steampipe-container-agent \
    --mount type=bind,source="${PWD}",target=/output \
      lanandra/steampipe-container-agent query "select access_key_id, user_name, create_date from aws_iam_access_key where create_date < current_date - interval '${KUNCEN_AWS_IAM_INTERVAL}' day" --output ${KUNCEN_AWS_IAM_OUTPUT}
fi

echo "[${DATETIMENOW}] finished"
