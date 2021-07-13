#!/bin/bash -l

set -xe;

# Dont know if is the best way but it works :)

echo 'Getting secrets from S3 bucket'

set +o xtrace

sh -c "aws configure set aws_access_key_id ${aws_access_key_id}"
sh -c "aws configure set aws_secret_access_key ${aws_secret_access_key}"
sh -c "aws configure set region ${aws_region}"

SECRETS=$(sed -n 's/.*"s3keyring:\(.*\)"/\1/p' ${deployment_file})

for SECRET in $SECRETS
do
  GROUP=$(echo "$SECRET" | cut -d. -f1)
  KEY=$(echo "$SECRET" | cut -d. -f2)
  PLAIN_SECRET=$(s3keyring --profile "${environment}" get "$GROUP" "$KEY")
  sed -ie 's/s3keyring:$SECRET/$PLAIN_SECRET/g' ${deployment_file}
done
set -o xtrace

echo 'All secrets decrypted'
