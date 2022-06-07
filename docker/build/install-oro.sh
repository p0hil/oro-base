#!/bin/bash

HOST=http://tuboul.loc
ORGANIZATION=Abra

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

cd /var/www

# Skeleton
COMPOSER_PROCESS_TIMEOUT=2000 composer create-project oro/commerce-crm-application ./ 5.0.2 -n

# Set parameters
echo "Copying parameters.yml ..."
cp /dist/config/parameters.yml /var/www/config/parameters.yml
echo -e "${GREEN}Done"

# Install oro
echo -e "${GREEN}Starting to install"
php bin/console oro:install -vvv --sample-data=y --application-url=${HOST} --user-name=admin \
    --user-email=admin@example.com --user-firstname=John --user-lastname=Doe --user-password=admin \
    --organization-name=${ORGANIZATION} --timeout=0 --symlink --env=prod -n


php bin/console oro:install -vvv --sample-data=y --application-url=http://oro-docker-mutagen.loc/ --user-name=admin \
    --user-email=admin@example.com --user-firstname=John --user-lastname=Doe --user-password=admin \
    --organization-name=Abra --timeout=0 --symlink --env=prod -n
