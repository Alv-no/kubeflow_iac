#!/usr/bin/env bash

# Install the juju olm from snap.
sudo snap install juju --classic
# Deploy the juju controller to the kubernetes 
# cluster set up with microk8s.
juju bootstrap microk8s
# Set up a specific model for kubeflow.
# Model name must be kubeflow.
juju add-model kubeflow

