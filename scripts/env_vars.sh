#!/bin/bash

# Set environment variables for Google Cloud
export GCP_PROJECT_ID=""
export GCP_SERVICE_ACCOUNT_NAME=""
export GCP_SERVICE_ACCOUNT_KEYFILE=""
export BASE64ENCODED_GCP_PROVIDER_CREDS=$(base64 $GCP_SERVICE_ACCOUNT_KEYFILE | tr -d "\n") # base64 encode the GCP credentials

export GKE_CLUSTER_NAME="t"
export GKE_CLUSTER_ZONE="europe-west3-a"


# Set environment vars for Crossplane installation
export CROSSPLANE_VERSION="1.6.0"
export CROSSPLANE_NS="crossplane-system"