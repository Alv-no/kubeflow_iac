#!/usr/bin/env bash

sudo snap install microk8s --classic --chanel=1.22/stable
sudo usermod -a -G microk8s $USER 

newgrp microk8s

sudo chown -f -R $USER ~/.kube

microk8s enable dns storage ingress metallb:10.64.140.43-10.64.140.49

microk8s status --wait-ready

