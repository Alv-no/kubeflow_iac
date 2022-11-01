#!/usr/bin/env bash

# Install microk8s from snap.
sudo snap install microk8s --classic --chanel=1.22/stable
# Create microk8s group and add the current user to the group.
sudo usermod -a -G microk8s $USER 
newgrp microk8s
# Ensure that the user has access and ownership of any 
# kubectl configutarion files
sudo chown -f -R $USER ~/.kube
# Enable the required microk8s services.
microk8s enable dns storage ingress metallb:10.64.140.43-10.64.140.49
# Check that the microk8s cluster is 
# running after enabling the services.
microk8s status --wait-ready

