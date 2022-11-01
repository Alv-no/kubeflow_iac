#!/usr/bin/env bash

# Deploy the (full-)kubeflow bundle. 
# For systems with limited resources, 
# use "kubeflow-lite" instead of "kubeflow".
juju deploy kubeflow --trust

# Local configurations
# Configure auth and access to kubeflow dashboard
juju config dex-auth public-url=http://10.64.140.43.nip.io
juju config oidc-gatekeeper public-url=http://10.64.140.43.nip.io
# Set up the user name and passwords
juju config dex-auth static-username=admin
juju config dex-auth static-password=admin

