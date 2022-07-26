#!/bin/bash

# Get Release Status
helm status ${HELM_RELEASE_NAME}

# If Helm Release does not exist
if [[ "${?}" -ne 0 ]]
then
    if [[ "$BLOG_UPDATED" -eq 1 ]]
    then
        echo "Releassing new with built image ..."
        # Helm Release does not exist. Need to deploy fresh with built image.
        helm upgrade --install ${HELM_RELEASE_NAME} --debug --dry-run ${HELM_RELEASE_DIR}/ \
        --set inputs.blogDeployBlue.image=${ECR_CONTAINER_REGISTRY}/blog:${SHA} \
        --set inputs.blogDeployGreen.image=${ECR_CONTAINER_REGISTRY}/blog:${SHA}

        helm upgrade --install ${HELM_RELEASE_NAME} --atomic --timeout 300s ${HELM_RELEASE_DIR}/ \
        --set inputs.blogDeployBlue.image=${ECR_CONTAINER_REGISTRY}/blog:${SHA} \
        --set inputs.blogDeployGreen.image=${ECR_CONTAINER_REGISTRY}/blog:${SHA}

    else
        echo "Releassing new with existing image ..."
        # Helm Release does not exist. Need to deploy fresh with existing image.
        helm upgrade --install ${HELM_RELEASE_NAME} ${HELM_RELEASE_DIR}/ --debug --dry-run
        helm upgrade --install ${HELM_RELEASE_NAME} ${HELM_RELEASE_DIR}/  --atomic --timeout 300s
    fi
    exit 0
fi

PRODSLOT=$(helm get values --all ${HELM_RELEASE_NAME} | grep "productionSlot" | sed 's/productionSlot\://g')

if [[ "$PRODSLOT" == "blue" ]]
then
    STAGESLOT="green"
else
    STAGESLOT="blue"
fi

if [[ "$BLOG_UPDATED" -eq 1 ]]
then

    echo "Source code has been updated. Deploying new built Image to stage !!"

    # Helm Debug output
    helm upgrade ${HELM_RELEASE_NAME} --debug --dry-run ${HELM_RELEASE_DIR}/ \
    --set inputs.blogDeploy${STAGESLOT}.image=${ECR_CONTAINER_REGISTRY}/blog:${SHA}
   
    # Helm Deploy
    helm upgrade ${HELM_RELEASE_NAME} --atomic --timeout 300s ${HELM_RELEASE_DIR}/ \
    --set inputs.blogDeploy${STAGESLOT}.image=${ECR_CONTAINER_REGISTRY}/blog:${SHA}

else
    
    echo "Upgrading stage release !!"
    # No Change in Source Code
    helm upgrade ${HELM_RELEASE_NAME} ${HELM_RELEASE_DIR}/ --debug --dry-run 
    helm upgrade ${HELM_RELEASE_NAME} ${HELM_RELEASE_DIR}/ --atomic --timeout 300s

fi
