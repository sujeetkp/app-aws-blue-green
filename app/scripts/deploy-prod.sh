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

CURRENTSLOT=$(helm get values --all ${HELM_RELEASE_NAME} | grep "productionSlot" | sed 's/productionSlot\://g')

if [[ "$CURRENTSLOT" == "blue" ]]
then
    NEWSLOT="green"
else
    NEWSLOT="blue"
fi

echo "Switching slot .."
echo "New Slot: $NEWSLOT"

# Switch Prod and Stage Slots
echo "helm upgrade ${HELM_RELEASE_NAME} ${HELM_RELEASE_DIR}/ --atomic --timeout 300s --set inputs.productionSlot=${NEWSLOT}"

helm upgrade ${HELM_RELEASE_NAME} ${HELM_RELEASE_DIR}/ --debug --dry-run --set inputs.productionSlot=${NEWSLOT}
helm upgrade ${HELM_RELEASE_NAME} ${HELM_RELEASE_DIR}/ --atomic --timeout 300s --set inputs.productionSlot=${NEWSLOT}

