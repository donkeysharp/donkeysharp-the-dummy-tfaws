#!/bin/bash

export MODULE_NAME=$1

if [[ -z ${MODULE_NAME} ]]; then
    echo "$0 <module-name>"
    echo "   Module name was not specified"
    exit 1
fi

mkdir -p modules/${MODULE_NAME}

touch modules/${MODULE_NAME}/{data.tf,main.tf,outputs.tf}

cp templates/versions.tf modules/${MODULE_NAME}/versions.tf
cp templates/variables.tf modules/${MODULE_NAME}/variables.tf

envsubst < templates/local.tf > modules/${MODULE_NAME}/local.tf
