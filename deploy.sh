#!/bin/bash

git pull && \

export RAILS_MASTER_KEY=$(aws ssm get-parameter --name /bana/back/RAILS_MASTER_KEY --query Parameter.Value --output text) && \
export DB_DATABASE=$(aws ssm get-parameter --name /bana/back/DB_DATABASE --query Parameter.Value --output text) && \
export DB_USERNAME=$(aws ssm get-parameter --name /bana/back/DB_USERNAME --query Parameter.Value --output text) && \
export DB_PASSWORD=$(aws ssm get-parameter --name /bana/back/DB_PASSWORD --query Parameter.Value --output text) && \
export DB_HOST=$(aws ssm get-parameter --name /bana/back/DB_HOST --query Parameter.Value --output text) && \
export ACCESS_KEY=$(aws ssm get-parameter --name /bana/back/ACCESS_KEY --query Parameter.Value --output text) && \
export SECRET_ACCESS_KEY=$(aws ssm get-parameter --name /bana/back/SECRET_ACCESS_KEY --query Parameter.Value --output text) && \
export S3_BUCKET=$(aws ssm get-parameter --name /bana/back/S3_BUCKET --query Parameter.Value --output text) && \

sudo docker build . -t bana-back && \

sudo docker container remove -f bana-back && \

sudo docker run -d --rm -p 3000:3000 --name bana-back \
 -e RAILS_MASTER_KEY=${RAILS_MASTER_KEY} \
 -e DB_DATABASE=${DB_DATABASE} \
 -e DB_USERNAME=${DB_USERNAME} \
 -e DB_PASSWORD=${DB_PASSWORD} \
 -e DB_HOST=${DB_HOST} \
 -e ACCESS_KEY=${ACCESS_KEY} \
 -e SECRET_ACCESS_KEY=${SECRET_ACCESS_KEY} \
 -e S3_BUCKET=${S3_BUCKET} \
 bana-back