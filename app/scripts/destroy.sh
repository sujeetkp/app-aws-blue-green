#!/bin/bash

# Debug Uninstall Application
helm uninstall --debug --dry-run ${HELM_RELEASE_NAME} 

# Uninstall Application
helm uninstall ${HELM_RELEASE_NAME} 

# list
helm list