#!/usr/bin/env bash

sudo snap install juju --classic

juju bootstrap microk8s
juju add-model kubeflow

