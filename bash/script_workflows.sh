#!/bin/sh

AWS_REGION=$(/opt/elasticbeanstalk/bin/get-config environment -k AWS_REGION)
AWS_SECRET_KEY=$(/opt/elasticbeanstalk/bin/get-config environment -k AWS_SECRET_KEY)
AWS_ACCESS_KEY=$(/opt/elasticbeanstalk/bin/get-config environment -k AWS_ACCESS_KEY)
S3_BUCKET_NAME=$(/opt/elasticbeanstalk/bin/get-config environment -k S3_BUCKET_NAME)
BRANCH=$(/opt/elasticbeanstalk/bin/get-config environment -k BRANCH)

SUB_DOMAIN=dev

case $BRANCH in
    "qa" | "QA" )
        SUB_DOMAIN=qa
    ;;
    "stage")
        SUB_DOMAIN=stage
    ;;
    "master" | "main" )
        SUB_DOMAIN=prod
    ;;
esac

echo "[AWS]
AWS_REGION=$AWS_REGION
AWS_SECRET_KEY=$AWS_SECRET_KEY
AWS_ACCESS_KEY=$AWS_ACCESS_KEY
S3_BUCKET_NAME=$S3_BUCKET_NAME
WP_DOMAIN=https://${SUB_DOMAIN}.test/"  > settings.ini

