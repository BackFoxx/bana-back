#!/bin/bash

git pull

RAILS_MASTER_KEY=$(aws ssm get-parameter --name /bana/back/RAILS_MASTER_KEY --query Parameter.Value --output text)
DB_DATABASE=$(aws ssm get-parameter --name /bana/back/DB_DATABASE --query Parameter.Value --output text)
DB_USERNAME=$(aws ssm get-parameter --name /bana/back/DB_USERNAME --query Parameter.Value --output text)
DB_PASSWORD=$(aws ssm get-parameter --name /bana/back/DB_PASSWORD --query Parameter.Value --output text)
DB_HOST=$(aws ssm get-parameter --name /bana/back/DB_HOST --query Parameter.Value --output text)

sudo docker build . -t bana-back

sudo docker container stop bana-back

sudo docker run -d --rm -p 3000:3000 --name bana-back \
 -e RAILS_MASTER_KEY=${RAILS_MASTER_KEY} \
 -e DB_DATABASE=${DB_DATABASE} \
 -e DB_USERNAME=${DB_USERNAME} \
 -e DB_PASSWORD=${DB_PASSWORD} \
 -e DB_HOST=${DB_HOST} \
 bana-back